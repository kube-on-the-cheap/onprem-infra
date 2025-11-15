# Edge Network Module - PXE Boot Infrastructure

This Terraform module configures a MikroTik router as a complete PXE boot infrastructure for automated NixOS installation on Raspberry Pi 4 and other devices.

## Features

- **Multi-architecture support** - Automatic detection via DHCP Option 93
  - ARM64 UEFI (Raspberry Pi 4)
  - x86_64 UEFI (Modern PCs/Intel Macs)
  - x86 BIOS (Legacy systems)
  - ARM32 UEFI (Older Raspberry Pis)

- **Optimized performance**
  - TFTP for initial bootloader (~1MB, 2-3 seconds)
  - HTTP for large files (~210MB, 20-30 seconds)
  - 4096-byte TFTP block size (8x faster than default)

- **Single server design**
  - Everything runs on MikroTik router
  - No separate PXE server needed
  - USB drive support for multi-architecture setups

## Quick Start

### 1. Apply Terraform Configuration

iPXE bootloaders are deployed automatically via Terraform from `files/boot/`:

```bash
cd config/<environment>
terragrunt apply
```

This will:
- Deploy iPXE bootloaders to MikroTik (ARM64, x86_64, BIOS)
- Create boot.ipxe script
- Configure DHCP with architecture detection
- Enable TFTP and HTTP servers

### 2. Upload NixOS Kexec Image (Manual)

The kexec image is too large (~210MB) for Terraform, upload via SCP:

```bash
# Download NixOS kexec installer
curl -L https://github.com/nix-community/nixos-images/releases/latest/download/nixos-kexec-installer-noninteractive-aarch64-linux.tar.gz -o /tmp/nixos-kexec.tar.gz

# Extract locally
mkdir -p /tmp/nixos-kexec
tar -xzf /tmp/nixos-kexec.tar.gz -C /tmp/nixos-kexec

# Upload to MikroTik (creates boot/nixos-kexec/ directory)
scp /tmp/nixos-kexec/* admin@192.168.20.1:/boot/nixos-kexec/
```

This configures:
- DHCP server with architecture detection
- TFTP server for bootloaders
- HTTP server for large files
- Boot file matchers

### 3. Boot Device via PXE

1. Configure device for network boot
   - **Raspberry Pi 4**: Update EEPROM for network boot
   - **PCs**: Enable PXE in BIOS/UEFI

2. Connect device to network with empty SD card/disk

3. Power on - device should:
   - Get DHCP lease with boot file
   - Download iPXE bootloader via TFTP
   - Chainload and fetch NixOS kexec via HTTP
   - Boot into NixOS installer

### 4. Deploy with nixos-anywhere

From your development machine:

```bash
# Wait for device to boot into NixOS installer
# Note the IP address from DHCP logs

# Deploy your NixOS configuration
nixos-anywhere --flake ~/.config/nix-darwin#rpi4 root@<DEVICE_IP>
```

The device will:
- Partition disk according to disko configuration
- Install NixOS from your flake
- Reboot into installed system

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│ MikroTik Router (192.168.20.1)                              │
│                                                              │
│ ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│ │ DHCP Server  │  │ TFTP Server  │  │ HTTP Server  │      │
│ │ Port 67      │  │ Port 69      │  │ Port 80      │      │
│ │              │  │              │  │              │      │
│ │ • Option 93  │  │ • 4KB blocks │  │ • boot.ipxe  │      │
│ │   matchers   │  │ • Rollover   │  │ • kernel     │      │
│ │ • Per-arch   │  │ • ~2-3s      │  │ • initrd     │      │
│ │   boot files │  │   transfers  │  │ • ~20-30s    │      │
│ └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                              │
│ Storage: /boot/ directory (~211MB for ARM64)                │
│          USB drive recommended for multi-arch (~425MB)      │
└─────────────────────────────────────────────────────────────┘
                              │
                              │ DHCP/TFTP/HTTP
                              ▼
        ┌─────────────────────────────────────┐
        │ Client Device (e.g., Raspberry Pi 4) │
        │                                       │
        │ 1. DHCP: Get boot file for ARM64     │
        │ 2. TFTP: Download ipxe-arm64.efi     │
        │ 3. iPXE: Chainload boot.ipxe         │
        │ 4. HTTP: Download kernel/initrd      │
        │ 5. Boot: NixOS kexec installer       │
        └─────────────────────────────────────┘
                              │
                              │ SSH (nixos-anywhere)
                              ▼
        ┌─────────────────────────────────────┐
        │ Development Machine                  │
        │ ~/.config/nix-darwin/                │
        │                                       │
        │ nixos-anywhere --flake .#rpi4 root@IP│
        └─────────────────────────────────────┘
```

## Files

### Terraform Configuration

- **`dhcp.tf`** - DHCP server and network configuration
- **`dhcp.pxe.tf`** - DHCP options for PXE boot (Options 66, 67)
- **`dhcp.matchers.tf`** - Architecture detection via Option 93
- **`tftp.tf`** - TFTP server configuration and optimization
- **`pxe-server.tf`** - HTTP server and iPXE boot script
- **`pxe-bootloaders.tf`** - iPXE bootloader deployment via Terraform

### Boot Files

- **`files/boot/ipxe-arm64.efi`** - ARM64 UEFI bootloader (~1MB)
- **`files/boot/ipxe-x86_64.efi`** - x86_64 UEFI bootloader (~1MB)
- **`files/boot/undionly.kpxe`** - x86 BIOS bootloader (~69KB)
- **`files/boot/snponly-arm64.efi`** - ARM64 SNP bootloader (~221KB)
- **`files/boot/snponly.efi`** - x86_64 SNP bootloader (~203KB)

### Documentation

- **`PXE-SETUP.md`** - Complete setup guide with troubleshooting
- **`ARCHITECTURE-DETECTION.md`** - Architecture detection deep dive
- **`OPTIMIZATIONS.md`** - Performance optimizations and rationale
- **`README.md`** - This file

### Scripts

- **`scripts/prepare-pxe-files.sh`** - Download and prepare all boot files

## Storage Requirements

### Single Architecture (ARM64 only)
- iPXE ARM64 bootloader: ~1 MB
- NixOS kexec image: ~210 MB
- **Total: ~211 MB** (fits on MikroTik internal storage)

### Multi-Architecture
- All iPXE bootloaders: ~5 MB
- ARM64 kexec: ~210 MB
- x86_64 kexec: ~210 MB
- **Total: ~425 MB** (requires USB drive)

## Testing

### Verify DHCP Matchers

```bash
ssh admin@192.168.20.1
/ip dhcp-server matcher print
```

Expected output:
```
# NAME          SERVER   CODE  VALUE    DHCP-OPTION
0 x86-bios      defconf  93    0x0000   boot-file-x86-bios
1 x86-64-uefi   defconf  93    0x0007   boot-file-x86-64-uefi
2 arm32-uefi    defconf  93    0x000a   boot-file-arm32-uefi
3 arm64-uefi    defconf  93    0x000b   boot-file-arm64-uefi
```

### Monitor PXE Boot

```bash
# Watch DHCP activity
/ip dhcp-server lease print detail

# Monitor TFTP transfers
/log print where topics~"tftp"

# Check HTTP access
/log print where topics~"info"

# Verify boot files exist
/file print where name~"boot"
```

### Test Architectures

1. **Raspberry Pi 4** - Should receive `boot/ipxe-arm64.efi`
2. **Modern PC** - Should receive `boot/ipxe-x86_64.efi`
3. **Legacy PC** - Should receive `boot/undionly.kpxe`

## Troubleshooting

### Client Gets Wrong Bootloader

**Check Option 93 support:**
```bash
# On client network, capture DHCP traffic
sudo tcpdump -i eth0 -vvv port 67 or port 68
# Look for "Client-Arch" in DHCP Discover
```

**Fallback to static lease:**
```bash
# On MikroTik
/ip dhcp-server lease add \
  mac-address=DC:A6:32:XX:XX:XX \
  address=192.168.20.110 \
  dhcp-option=boot-file-arm64-uefi \
  comment="Raspberry Pi 4"
```

### TFTP Timeout

**Check TFTP service:**
```bash
/ip service print where name=tftp
# Should show: disabled=no, port=69
```

**Check TFTP settings:**
```bash
/ip tftp print
# Should show: max-block-size=4096
```

**Test from client:**
```bash
# On Linux client
tftp 192.168.20.1 -c get boot/ipxe-arm64.efi
```

### HTTP Files Not Found

**Verify HTTP service:**
```bash
/ip service print where name=www
# Should show: disabled=no, port=80
```

**Check files exist:**
```bash
/file print where name~"boot"
# Should show boot.ipxe and nixos-kexec files
```

**Test from client:**
```bash
curl http://192.168.20.1/boot/boot.ipxe
```

### No DHCP Lease

**Check DHCP server:**
```bash
/ip dhcp-server print
# Should show: disabled=no, interface=bridge
```

**Check address pool:**
```bash
/ip pool print where name=dhcp
# Should show available addresses
```

**Monitor DHCP requests:**
```bash
/log print where topics~"dhcp"
```

## Performance Tuning

Current configuration is optimized for:
- Gigabit Ethernet
- LAN-only deployment
- <10 simultaneous boots

For higher loads, consider:
- Dedicated PXE server with faster storage
- HTTP caching/compression
- Multiple TFTP/HTTP servers with load balancing

## Security Considerations

**Current setup (no security):**
- TFTP: No authentication or encryption
- HTTP: No authentication or encryption
- DHCP: No security

**Acceptable for:**
- Isolated homelab network
- Trusted physical environment
- Initial provisioning only

**For production:**
- Use HTTPS instead of HTTP
- Implement network segmentation
- Use signed bootloaders
- Enable DHCP snooping

## References

- [PXE Boot Setup Guide](./PXE-SETUP.md)
- [Architecture Detection Details](./ARCHITECTURE-DETECTION.md)
- [Performance Optimizations](./OPTIMIZATIONS.md)
- [RFC 4578 - DHCP PXE Options](https://datatracker.ietf.org/doc/html/rfc4578)
- [iPXE Documentation](https://ipxe.org/)
- [nixos-anywhere](https://github.com/nix-community/nixos-anywhere)

## Next Steps

1. ✅ iPXE bootloaders in files/boot/
2. ⏳ Apply Terraform (deploys bootloaders automatically)
3. ⏳ Upload NixOS kexec image (~210MB) via SCP
4. ⏳ Test PXE boot with Raspberry Pi 4
5. ⏳ Deploy with nixos-anywhere
6. ⏳ Verify installed system boots from SD card

## Support

For issues:
1. Check [Troubleshooting](#troubleshooting) section
2. Review MikroTik logs: `/log print`
3. Verify configuration: `/export file=config`
4. Check this repository's documentation

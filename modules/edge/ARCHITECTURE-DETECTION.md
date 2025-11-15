# Architecture Detection for PXE Boot

## Problem

Different devices need different PXE bootloaders:
- **Raspberry Pi 4**: ARM64 UEFI bootloader
- **Modern PCs/Intel Macs**: x86_64 UEFI bootloader
- **Legacy systems**: x86 BIOS bootloader
- **Older Raspberry Pis**: ARM32 UEFI bootloader

## Solution: DHCP Option 93 Matching

MikroTik can detect client architecture using **DHCP Option 93** (Client System Architecture Type) and serve the appropriate bootloader.

### How It Works

```
Client boots → Sends DHCP Discover with Option 93 →
MikroTik checks Option 93 value →
Matches against configured matchers →
Serves appropriate bootloader via Option 67
```

### Architecture Type Codes (Option 93)

| Code | Architecture | Bootloader | Devices |
|------|--------------|------------|---------|
| `0x0000` | x86 BIOS | `boot/undionly.kpxe` | Legacy PCs |
| `0x0007` | x86_64 UEFI | `boot/ipxe-x86_64.efi` | Modern PCs, Intel Macs |
| `0x000a` | ARM32 UEFI | `boot/ipxe-arm32.efi` | RPi 2/3 |
| `0x000b` | ARM64 UEFI | `boot/ipxe-arm64.efi` | Raspberry Pi 4 |

## Configuration Files

### 1. DHCP Options (`dhcp.pxe.tf`)

Defines the available bootloader options:

```hcl
resource "routeros_ip_dhcp_server_option" "boot_file_arm64_uefi" {
  name  = "boot-file-arm64-uefi"
  code  = 67
  value = "s'boot/ipxe-arm64.efi'"
}

resource "routeros_ip_dhcp_server_option" "boot_file_x86_64_uefi" {
  name  = "boot-file-x86-64-uefi"
  code  = 67
  value = "s'boot/ipxe-x86_64.efi'"
}
```

### 2. DHCP Matchers (`dhcp.matchers.tf`)

Maps Option 93 values to bootloader options:

```hcl
resource "routeros_ip_dhcp_server_matcher" "arm64_uefi" {
  name        = "arm64-uefi"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  code        = 93  # Client System Architecture Type
  value       = "0x000b"
  dhcp_option = routeros_ip_dhcp_server_option.boot_file_arm64_uefi.name
}
```

### 3. Default Fallback (`dhcp.tf`)

If no matcher applies, uses x86_64 UEFI as default:

```hcl
resource "routeros_ip_dhcp_server_network" "lan" {
  boot_file_name = "boot/ipxe-x86_64.efi"  # Default
  # ...
}
```

## Testing

### 1. Verify Matchers Are Configured

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

### 2. Check DHCP Leases During Boot

When a device PXE boots, check what it received:

```bash
/ip dhcp-server lease print detail
```

Look for the matched option in the lease details.

### 3. Monitor DHCP Logs

```bash
/log print where topics~"dhcp"
```

### 4. Test Specific Architecture

#### Raspberry Pi 4 (ARM64)
```bash
# Boot Pi with empty SD card
# Should receive: boot/ipxe-arm64.efi
```

#### Modern PC/Intel Mac (x86_64)
```bash
# PXE boot an Intel system
# Should receive: boot/ipxe-x86_64.efi
```

#### Legacy PC (x86 BIOS)
```bash
# PXE boot a BIOS system
# Should receive: boot/undionly.kpxe
```

## Troubleshooting

### Client Doesn't Send Option 93

**Symptom**: All devices get the default bootloader regardless of architecture

**Solutions**:

1. **Update client firmware** - Modern UEFI implementations should send Option 93

2. **Use MAC-based identification** for known devices:
   ```bash
   # On MikroTik:
   /ip dhcp-server lease add \
     mac-address=DC:A6:32:XX:XX:XX \
     address=192.168.20.110 \
     dhcp-option=boot-file-arm64-uefi \
     comment="Raspberry Pi 4"
   ```

3. **Check with tcpdump** on the client network:
   ```bash
   sudo tcpdump -i eth0 -vvv port 67 or port 68
   # Look for "Client-Arch" in DHCP Discover
   ```

### Wrong Bootloader Served

**Check matcher order**:
```bash
/ip dhcp-server matcher print
```

Matchers are evaluated in order. Ensure more specific matchers come first.

**Verify Option 93 value**:
```bash
# Capture DHCP traffic and check what the client sends
/tool sniffer quick port=67-68
```

### Matcher Not Applied

**Verify DHCP option exists**:
```bash
/ip dhcp-server option print
```

**Check matcher syntax**:
- Value must be hex: `0x000b` (not `11` decimal)
- Option code must be `93`
- DHCP option name must match exactly

## Alternative: Static Leases by Device

For known devices, you can skip automatic detection:

```hcl
# In dhcp.leases.tf
resource "routeros_ip_dhcp_server_lease" "rpi4" {
  address     = "192.168.20.110"
  mac_address = "dc:a6:32:xx:xx:xx"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "Raspberry Pi 4 - PXE boot"

  # Force ARM64 bootloader for this device
  dhcp_option = routeros_ip_dhcp_server_option.boot_file_arm64_uefi.name
}
```

## iPXE Chainloading

Once iPXE is loaded, it's architecture-aware and can handle multi-arch environments:

### Option 1: Single boot.ipxe with Detection

```ipxe
#!ipxe

# Detect architecture
iseq ${buildarch} arm64 && goto arm64 ||
iseq ${buildarch} arm && goto arm32 ||
iseq ${buildarch} x86_64 && goto x86_64 ||
goto unknown

:arm64
echo Detected ARM64 architecture
set kexec-url http://192.168.20.1/boot/nixos-kexec-arm64
goto boot

:arm32
echo Detected ARM32 architecture
set kexec-url http://192.168.20.1/boot/nixos-kexec-arm32
goto boot

:x86_64
echo Detected x86_64 architecture
set kexec-url http://192.168.20.1/boot/nixos-kexec-x86_64
goto boot

:boot
kernel ${kexec-url}/bzImage
initrd ${kexec-url}/initrd
boot

:unknown
echo ERROR: Unknown architecture ${buildarch}
shell
```

### Option 2: Separate boot scripts per architecture

Serve different `boot.ipxe` based on path:
- ARM64: `boot/arm64/boot.ipxe`
- x86_64: `boot/x86_64/boot.ipxe`

Update bootloaders to fetch appropriate script:
```bash
# When building custom iPXE, embed the arch-specific script URL
```

## File Organization

```
/boot/
├── ipxe-arm64.efi          # ARM64 UEFI bootloader
├── ipxe-x86_64.efi         # x86_64 UEFI bootloader
├── ipxe-arm32.efi          # ARM32 UEFI bootloader
├── undionly.kpxe           # x86 BIOS bootloader
├── boot.ipxe               # Universal boot script (arch detection)
└── nixos-kexec/
    ├── arm64/
    │   ├── bzImage
    │   └── initrd
    └── x86_64/
        ├── bzImage
        └── initrd
```

## Storage Requirements

Per architecture:
- iPXE bootloader: ~1MB
- NixOS kexec image: ~210MB

**Total for multi-arch**:
- All bootloaders: ~5MB
- ARM64 kexec: ~210MB
- x86_64 kexec: ~210MB (if needed)
- **Total**: ~425MB

Consider using USB drive on MikroTik if supporting multiple architectures.

## References

- [RFC 4578 - DHCP Client Architecture](https://datatracker.ietf.org/doc/html/rfc4578)
- [iPXE Architecture Detection](https://ipxe.org/buildcfg/arch)
- [MikroTik DHCP Server](https://help.mikrotik.com/docs/display/ROS/DHCP#DHCP-Matcher)

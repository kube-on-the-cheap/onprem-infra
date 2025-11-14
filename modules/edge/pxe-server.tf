# PXE Server Configuration for Raspberry Pi 4 Network Boot
#
# This configures the MikroTik to serve PXE boot files directly without
# needing a separate server at 192.168.20.200
#
# Architecture:
# 1. DHCP points to Mikrotik's IP for PXE
# 2. TFTP serves iPXE bootloader (from /usb1/boot)
# 3. HTTP serves NixOS kexec image (from /usb1/boot via built-in web server)
# 4. iPXE chainloads the kexec image
# 5. Pi boots into NixOS installer
# 6. nixos-anywhere deploys from your flake

# Enable HTTP server for serving boot files
resource "routeros_ip_service" "www" {
  numbers  = "www"
  disabled = false
  port     = 80
}

# Script to download PXE boot files
# Run this once on the MikroTik: /system script run download-pxe-files
resource "routeros_system_script" "download_pxe_files" {
  name   = "download-pxe-files"
  policy = ["read", "write", "test", "ftp"]
  source = <<-EOT
    # Download PXE boot files to USB drive
    # This script downloads iPXE bootloaders and creates the boot script

    :log info "Starting PXE boot files download..."

    # Create directories
    :do {
      /file/make-directory name=usb1/boot
      /file/make-directory name=usb1/boot/nixos-kexec
    } on-error={
      :log info "Directories already exist or USB not mounted"
    }

    :log info "Downloading iPXE bootloaders..."

    # ARM64 UEFI (Raspberry Pi 4)
    :do {
      /tool fetch url="https://boot.ipxe.org/arm64-efi/ipxe.efi" dst-path="usb1/boot/ipxe-arm64.efi" mode=https
      :log info "Downloaded ipxe-arm64.efi"
    } on-error={
      :log error "Failed to download ipxe-arm64.efi"
    }

    # x86_64 UEFI (Modern PCs)
    :do {
      /tool fetch url="https://boot.ipxe.org/ipxe.efi" dst-path="usb1/boot/ipxe-x86_64.efi" mode=https
      :log info "Downloaded ipxe-x86_64.efi"
    } on-error={
      :log error "Failed to download ipxe-x86_64.efi"
    }

    # x86 BIOS (Legacy)
    :do {
      /tool fetch url="https://boot.ipxe.org/undionly.kpxe" dst-path="usb1/boot/undionly.kpxe" mode=https
      :log info "Downloaded undionly.kpxe"
    } on-error={
      :log error "Failed to download undionly.kpxe"
    }

    # SNP-only ARM64 (alternative)
    :do {
      /tool fetch url="https://boot.ipxe.org/arm64-efi/snponly.efi" dst-path="usb1/boot/snponly-arm64.efi" mode=https
      :log info "Downloaded snponly-arm64.efi"
    } on-error={
      :log error "Failed to download snponly-arm64.efi"
    }

    # SNP-only x86_64 (alternative)
    :do {
      /tool fetch url="https://boot.ipxe.org/snponly.efi" dst-path="usb1/boot/snponly.efi" mode=https
      :log info "Downloaded snponly.efi"
    } on-error={
      :log error "Failed to download snponly.efi"
    }

    :log info "PXE bootloaders download complete!"
    :log info "List files with: /file print where name~\"usb1/boot\""
    :log info ""
    :log info "Next: Download NixOS kexec image (~210MB) manually:"
    :log info "  /tool fetch url=\"https://github.com/nix-community/nixos-images/releases/latest/download/nixos-kexec-installer-noninteractive-aarch64-linux.tar.gz\" dst-path=\"usb1/boot/nixos-kexec.tar.gz\" mode=https"
    :log info "  Then extract on your computer and upload via SCP"
  EOT
}

# iPXE boot script
resource "routeros_system_script" "ipxe_boot_script" {
  name   = "create-ipxe-boot-script"
  policy = ["read", "write", "test"]
  source = <<-EOT
    # Create iPXE boot script
    /file print file=usb1/boot/boot.ipxe

    :local content "#!ipxe\r\n\
      \r\n\
      echo ========================================\r\n\
      echo NixOS Network Installer\r\n\
      echo ========================================\r\n\
      echo\r\n\
      echo MAC: \$\{net0/mac\}\r\n\
      echo IP: \$\{net0/ip\}\r\n\
      echo\r\n\
      \r\n\
      # Set base URL to Mikrotik's IP\r\n\
      set base-url http://192.168.20.1/usb1/boot\r\n\
      \r\n\
      echo Fetching NixOS kexec installer...\r\n\
      kernel \$\{base-url\}/nixos-kexec/bzImage init=/nix/store/*/init loglevel=4\r\n\
      initrd \$\{base-url\}/nixos-kexec/initrd\r\n\
      \r\n\
      echo Booting NixOS installer...\r\n\
      boot"

    /file set usb1/boot/boot.ipxe contents=\$content
    :log info "Created boot.ipxe script"
  EOT
}

# Instructions script
resource "routeros_system_script" "pxe_instructions" {
  name   = "pxe-boot-instructions"
  policy = ["read"]
  source = <<-EOT
    :log info "=== PXE Boot Setup Instructions ==="
    :log info ""
    :log info "1. Download boot files:"
    :log info "   /system script run download-pxe-files"
    :log info ""
    :log info "2. Create iPXE boot script:"
    :log info "   /system script run create-ipxe-boot-script"
    :log info ""
    :log info "3. Download NixOS kexec image (~210MB):"
    :log info "   /tool fetch url=\"https://github.com/nix-community/nixos-images/releases/latest/download/nixos-kexec-installer-noninteractive-aarch64-linux.tar.gz\" dst-path=\"usb1/boot/nixos-kexec.tar.gz\" mode=https"
    :log info ""
    :log info "4. Extract kexec tarball (on your computer, then upload via SCP):"
    :log info "   tar -xzf nixos-kexec.tar.gz"
    :log info "   scp bzImage initrd admin@192.168.20.1:/usb1/boot/nixos-kexec/"
    :log info ""
    :log info "5. Verify files:"
    :log info "   /file print where name~\"usb1/boot\""
    :log info ""
    :log info "6. Test PXE boot with Raspberry Pi 4"
    :log info ""
  EOT
}

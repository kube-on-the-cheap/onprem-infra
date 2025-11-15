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

    :log info "Downloading iPXE bootloaders to usb1-part2/boot/..."

    # ARM64 UEFI (Raspberry Pi 4)
    :do {
      /tool fetch url="https://boot.ipxe.org/arm64-efi/ipxe.efi" dst-path="usb1-part2/boot/ipxe-arm64.efi" mode=https
      :log info "Downloaded ipxe-arm64.efi"
    } on-error={
      :log error "Failed to download ipxe-arm64.efi"
    }

    # x86_64 UEFI (Modern PCs)
    :do {
      /tool fetch url="https://boot.ipxe.org/ipxe.efi" dst-path="usb1-part2/boot/ipxe-x86_64.efi" mode=https
      :log info "Downloaded ipxe-x86_64.efi"
    } on-error={
      :log error "Failed to download ipxe-x86_64.efi"
    }

    # x86 BIOS (Legacy)
    :do {
      /tool fetch url="https://boot.ipxe.org/undionly.kpxe" dst-path="usb1-part2/boot/undionly.kpxe" mode=https
      :log info "Downloaded undionly.kpxe"
    } on-error={
      :log error "Failed to download undionly.kpxe"
    }

    # SNP-only ARM64 (alternative)
    :do {
      /tool fetch url="https://boot.ipxe.org/arm64-efi/snponly.efi" dst-path="usb1-part2/boot/snponly-arm64.efi" mode=https
      :log info "Downloaded snponly-arm64.efi"
    } on-error={
      :log error "Failed to download snponly-arm64.efi"
    }

    # SNP-only x86_64 (alternative)
    :do {
      /tool fetch url="https://boot.ipxe.org/snponly.efi" dst-path="usb1-part2/boot/snponly.efi" mode=https
      :log info "Downloaded snponly.efi"
    } on-error={
      :log error "Failed to download snponly.efi"
    }

    :log info "PXE bootloaders download complete!"
    :log info ""
    :log info "Downloading NixOS kexec images (~210MB each)..."
    :log info "This may take several minutes..."
    :log info ""

    # ARM64 kexec image (Raspberry Pi 4, ARM servers)
    :do {
      /tool fetch url="https://github.com/nix-community/nixos-images/releases/latest/download/nixos-kexec-installer-noninteractive-aarch64-linux.tar.gz" dst-path="usb1-part2/boot/nixos-kexec-aarch64.tar.gz" mode=https http-max-redirect-count=2
      :log info "Downloaded ARM64 kexec image"
    } on-error={
      :log error "Failed to download ARM64 kexec image"
    }

    # x86_64 kexec image (Intel/AMD PCs)
    :do {
      /tool fetch url="https://github.com/nix-community/nixos-images/releases/latest/download/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz" dst-path="usb1-part2/boot/nixos-kexec-x86_64.tar.gz" mode=https http-max-redirect-count=2
      :log info "Downloaded x86_64 kexec image"
    } on-error={
      :log error "Failed to download x86_64 kexec image"
    }

    :log info ""
    :log info "Download complete!"
    :log info ""
    :log info "Copying bootloaders to internal flash for TFTP access..."
    :log info "(TFTP cannot serve files from USB drives)"
    :log info ""

    # Create boot directory on internal flash
    :do {
      /file/make-directory name=boot
      :log info "Created /boot directory"
    } on-error={
      :log info "Directory /boot already exists"
    }

    # Copy bootloaders from USB to internal flash
    # TFTP can only serve files from internal flash, not USB drives
    :foreach bootfile in={"ipxe-arm64.efi";"ipxe-x86_64.efi";"undionly.kpxe";"snponly-arm64.efi";"snponly.efi"} do={
      :local srcPath ("usb1-part2/boot/" . $bootfile)
      :local dstPath ("boot/" . $bootfile)
      :do {
        /file/copy src=$srcPath dst=$dstPath
        :log info ("Copied " . $bootfile . " to internal flash")
      } on-error={
        :log error ("Failed to copy " . $bootfile)
      }
    }

    :log info ""
    :log info "Bootloader setup complete!"
    :log info "List files with: /file print where name~\"boot\""
    :log info ""
    :log info "Next: Extract kexec images (on your computer and upload via SCP):"
    :log info "  # ARM64:"
    :log info "  scp admin@192.168.20.1:/usb1-part2/boot/nixos-kexec-aarch64.tar.gz /tmp/"
    :log info "  tar -xzf /tmp/nixos-kexec-aarch64.tar.gz -C /tmp"
    :log info "  scp /tmp/nixos-kexec-installer-noninteractive-aarch64-linux/* admin@192.168.20.1:/usb1-part2/boot/nixos-kexec/aarch64/"
    :log info ""
    :log info "  # x86_64:"
    :log info "  scp admin@192.168.20.1:/usb1-part2/boot/nixos-kexec-x86_64.tar.gz /tmp/"
    :log info "  tar -xzf /tmp/nixos-kexec-x86_64.tar.gz -C /tmp"
    :log info "  scp /tmp/nixos-kexec-installer-noninteractive-x86_64-linux/* admin@192.168.20.1:/usb1-part2/boot/nixos-kexec/x86_64/"
  EOT
}

# iPXE boot script - deployed as file
resource "routeros_file" "ipxe_boot_script" {
  name     = "usb1-part2/boot/boot.ipxe"
  contents = file("${path.module}/files/boot.ipxe")
}

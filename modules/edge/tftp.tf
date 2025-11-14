# TFTP Server Configuration for PXE Boot
#
# TFTP is used only for initial iPXE bootloader download (~1MB)
# Large files (kernel/initrd) are served via HTTP for better performance

# Note: TFTP service is always enabled on MikroTik RouterOS
# It cannot be disabled via Terraform, but can be controlled via:
#   /ip tftp print
#   /tool fetch tftp://192.168.20.1/boot/ipxe-arm64.efi
#
# The TFTP server automatically serves files from the root directory (/)

# TFTP Settings - Performance optimization
resource "routeros_ip_tftp_settings" "this" {
  # Maximum TFTP block size (default: 512 bytes)
  # 4096 provides ~8x better performance for bootloader transfers
  # Supports RFC 2348 (Block size negotiation)
  max_block_size = 4096

  # Note: MikroTik RouterOS TFTP server automatically provides:
  # - RFC 2348 (Block size negotiation) - enabled via max_block_size
  # - RFC 2349 (Transfer size option) - always supported
  # - Rollover for large files (>32MB) - always supported
  #
  # Typical bootloader sizes:
  # - iPXE EFI: ~1MB (transfers in ~2-3 seconds with 4096 block size)
  # - BIOS bootloader: ~100KB (transfers in <1 second)
  #
  # For larger files (kernel/initrd), iPXE uses HTTP instead of TFTP
  # See pxe-server.tf for HTTP server configuration
}

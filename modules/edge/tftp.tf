# TFTP Server Configuration for PXE Boot
#
# TFTP is used only for initial iPXE bootloader download (~1MB)
# Large files (kernel/initrd) are served via HTTP for better performance
#
# IMPORTANT: The TFTP server can ONLY serve files from internal flash storage (/)
# It CANNOT serve files from USB drives (usb1-part1, usb1-part2, etc.)
# Bootloader files must be copied to /boot on internal flash for TFTP access
#
# CRITICAL: TFTP server requires at least one access rule to start
# Without rules configured, the TFTP server will not start at boot

# TFTP Access Rule - Allow serving files from root directory
# This rule is required for the TFTP server to start
resource "routeros_ip_tftp" "allow_all" {
  req_filename  = ".*"
  real_filename = "/"
  allow         = true
  read_only     = true
}

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

# DHCP Server Options for PXE Boot
#
# These options are used in option sets assigned to specific clients via static leases.
#
# IMPORTANT: Do NOT set next-server or boot-file-name in the network definition (dhcp.tf)
# "If there is an option present in the network definition (even if it is not set),
# then setting an option with the proper code is useless."
# - https://blog.xentoo.info/2013/12/22/mikrotik-dhcp-and-pxe-boot/
#
# Client Architecture Types (Option 93) - for reference:
# 0x0000 = x86 BIOS
# 0x0006 = x86 UEFI (32-bit)
# 0x0007 = x86_64 UEFI (64-bit)
# 0x0009 = x86_64 UEFI HTTP
# 0x000a = ARM32 UEFI
# 0x000b = ARM64 UEFI (Raspberry Pi 4)

# Option 66: TFTP server address (Mikrotik's LAN IP)
resource "routeros_ip_dhcp_server_option" "next_server" {
  name  = "next-server"
  code  = 66
  value = "s'192.168.20.1'"
}

# Boot file options for different architectures

# x86 BIOS (legacy)
resource "routeros_ip_dhcp_server_option" "boot_file_x86_bios" {
  name  = "boot-file-x86-bios"
  code  = 67
  value = "s'boot/undionly.kpxe'"
}

# x86_64 UEFI
resource "routeros_ip_dhcp_server_option" "boot_file_x86_64_uefi" {
  name  = "boot-file-x86-64-uefi"
  code  = 67
  value = "s'boot/ipxe-x86_64.efi'"
}

# ARM64 UEFI (Raspberry Pi 4)
resource "routeros_ip_dhcp_server_option" "boot_file_arm64_uefi" {
  name  = "boot-file-arm64-uefi"
  code  = 67
  value = "s'boot/ipxe-arm64.efi'"
}

# # ARM32 UEFI (older Raspberry Pi models)
# resource "routeros_ip_dhcp_server_option" "boot_file_arm32_uefi" {
#   name  = "boot-file-arm32-uefi"
#   code  = 67
#   value = "s'boot/ipxe-arm32.efi'"
# }

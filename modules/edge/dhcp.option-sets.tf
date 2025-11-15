# DHCP Option Sets for PXE Boot
#
# Option sets group DHCP options together so they can be assigned to specific clients.
# Each set includes both next-server (Option 66) and boot-file (Option 67).
#
# IMPORTANT: Do NOT set next-server or boot-file-name in the network definition (dhcp.tf)
# "If there is an option present in the network definition (even if it is not set),
# then setting an option with the proper code is useless."
#
# These option sets are assigned to clients via static leases (dhcp.leases.tf)

# x86 BIOS Option Set
resource "routeros_ip_dhcp_server_option_set" "x86_bios" {
  name    = "pxe-x86-bios"
  options = "${routeros_ip_dhcp_server_option.next_server.name},${routeros_ip_dhcp_server_option.boot_file_x86_bios.name}"
  # comment = "x86 BIOS PXE Boot"
}

# x86_64 UEFI Option Set
resource "routeros_ip_dhcp_server_option_set" "x86_64_uefi" {
  name    = "pxe-x86-64-uefi"
  options = "${routeros_ip_dhcp_server_option.next_server.name},${routeros_ip_dhcp_server_option.boot_file_x86_64_uefi.name}"
  # comment = "x86_64 UEFI PXE Boot"
}

# ARM64 UEFI Option Set (Raspberry Pi 4)
resource "routeros_ip_dhcp_server_option_set" "arm64_uefi" {
  name    = "pxe-arm64-uefi"
  options = "${routeros_ip_dhcp_server_option.next_server.name},${routeros_ip_dhcp_server_option.boot_file_arm64_uefi.name}"
  # comment = "ARM64 UEFI PXE Boot (Raspberry Pi 4)"
}

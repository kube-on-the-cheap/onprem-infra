# DHCP Option Sets for PXE Boot
#
# Option sets group DHCP options together so they can be assigned
# to clients via matchers or static leases
#
# Note: options field expects a single comma-separated string

# x86 BIOS Option Set
resource "routeros_ip_dhcp_server_option_set" "x86_bios" {
  name = "pxe-x86-bios"
  options = join(",", [
    routeros_ip_dhcp_server_option.next_server.name,
    routeros_ip_dhcp_server_option.boot_file_x86_bios.name,
  ])
}

# x86_64 UEFI Option Set
resource "routeros_ip_dhcp_server_option_set" "x86_64_uefi" {
  name = "pxe-x86-64-uefi"
  options = join(",", [
    routeros_ip_dhcp_server_option.next_server.name,
    routeros_ip_dhcp_server_option.boot_file_x86_64_uefi.name,
  ])
}

# ARM64 UEFI Option Set (Raspberry Pi 4)
resource "routeros_ip_dhcp_server_option_set" "arm64_uefi" {
  name = "pxe-arm64-uefi"
  options = join(",", [
    routeros_ip_dhcp_server_option.next_server.name,
    routeros_ip_dhcp_server_option.boot_file_arm64_uefi.name,
  ])
}

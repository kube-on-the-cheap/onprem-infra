# DHCP Server Matchers for Architecture-Specific PXE Boot
#
# These matchers detect the client architecture from DHCP Option 93
# (Client System Architecture Type) and serve the appropriate bootloader

# Matcher for x86 BIOS clients (Option 93 = 0x0000)
resource "routeros_ip_dhcp_server_option_matcher" "x86_bios" {
  name          = "x86-bios"
  server        = routeros_ip_dhcp_server.dhcp_server.name
  code          = 93  # Client System Architecture Type
  value         = "0x0000"
  matching_type = "exact"
  option_set    = routeros_ip_dhcp_server_option_set.x86_bios.name
}

# Matcher for x86_64 UEFI clients (Option 93 = 0x0007)
resource "routeros_ip_dhcp_server_option_matcher" "x86_64_uefi" {
  name          = "x86-64-uefi"
  server        = routeros_ip_dhcp_server.dhcp_server.name
  code          = 93
  value         = "0x0007"
  matching_type = "exact"
  option_set    = routeros_ip_dhcp_server_option_set.x86_64_uefi.name
}

# # Matcher for ARM32 UEFI clients (Option 93 = 0x000a)
# # Commented out - add option set in dhcp.option-sets.tf if needed
# resource "routeros_ip_dhcp_server_option_matcher" "arm32_uefi" {
#   name          = "arm32-uefi"
#   server        = routeros_ip_dhcp_server.dhcp_server.name
#   code          = 93
#   value         = "0x000a"
#   matching_type = "exact"
#   option_set    = routeros_ip_dhcp_server_option_set.arm32_uefi.name
# }

# Matcher for ARM64 UEFI clients (Option 93 = 0x000b) - Raspberry Pi 4
resource "routeros_ip_dhcp_server_option_matcher" "arm64_uefi" {
  name          = "arm64-uefi"
  server        = routeros_ip_dhcp_server.dhcp_server.name
  code          = 93
  value         = "0x000b"
  matching_type = "exact"
  option_set    = routeros_ip_dhcp_server_option_set.arm64_uefi.name
}

# Note: MAC address-based matching is not supported by DHCP option matchers
# For devices that don't send Option 93, use static leases instead:
#
# resource "routeros_ip_dhcp_server_lease" "rpi4_pxe" {
#   address     = "192.168.20.110"
#   mac_address = "dc:a6:32:xx:xx:xx"
#   server      = routeros_ip_dhcp_server.dhcp_server.name
#   dhcp_option = routeros_ip_dhcp_server_option.boot_file_arm64_uefi.name
#   comment     = "Raspberry Pi 4 - Force ARM64 bootloader"
# }
#
# Raspberry Pi Foundation MAC prefixes: B8:27:EB, DC:A6:32, E4:5F:01

resource "routeros_ip_dhcp_server_lease" "dietpi" {
  address     = "192.168.20.200"
  mac_address = "B8:27:EB:EB:45:C2"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "DietPi"
}

resource "routeros_ip_dhcp_server_lease" "nasser" {
  address     = "192.168.20.16"
  mac_address = "B0:5A:DA:87:4A:D0"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "NASser"
}

resource "routeros_ip_dhcp_server_lease" "nas" {
  address     = "192.168.20.15"
  mac_address = "00:11:32:46:96:EB"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "NAS"
}

resource "routeros_ip_dhcp_server_lease" "simpleton" {
  address     = "192.168.20.111"
  mac_address = "42:AE:F3:F6:27:FF"
  # client_id   = "1:42:ae:f3:f6:27:ff"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "simpleton"
}

resource "routeros_ip_dhcp_server_lease" "minipc" {
  address     = "192.168.20.112"
  mac_address = "48:21:0B:37:9E:00"
  # client_id   = "1:48:21:0b:37:9e:00"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "minipc"
}

resource "routeros_ip_dhcp_server_lease" "rainbowparty" {
  address     = "192.168.20.125"
  mac_address = "3C:7C:3F:1D:81:66"
  # client_id   = "1:3c:7c:3f:1d:81:66"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "RainbowParty"
}

# ============================================================================
# PXE Boot Leases
# ============================================================================
# For devices that don't send DHCP Option 93, we need to set boot options
# explicitly via static leases based on MAC address

# Raspberry Pi 4 - PXE Boot
# Raspberry Pi Foundation MAC prefixes: B8:27:EB, DC:A6:32, E4:5F:01
# These devices need ARM64 bootloader since they don't send Option 93

resource "routeros_ip_dhcp_server_lease" "rpi4" {
  address         = "192.168.20.110"
  mac_address     = "D8:3A:DD:B3:86:1C"
  server          = routeros_ip_dhcp_server.dhcp_server.name
  dhcp_option_set = routeros_ip_dhcp_server_option_set.arm64_uefi.name
  comment         = "Raspberry Pi 4 (ARM64) - PXE Boot"
}

# Example: x86_64 machine that doesn't send Option 93
# resource "routeros_ip_dhcp_server_lease" "intel_nuc_pxe" {
#   address     = "192.168.20.120"
#   mac_address = "AA:BB:CC:DD:EE:FF"
#   server      = routeros_ip_dhcp_server.dhcp_server.name
#   dhcp_option_set = routeros_ip_dhcp_server_option_set.x86_64_uefi.name
#   comment     = "Intel NUC - PXE Boot (x86_64)"
# }

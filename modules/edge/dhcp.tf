resource "routeros_ip_pool" "dhcp" {
  name   = "dhcp"
  ranges = ["192.168.20.90-192.168.20.180"]
}

resource "routeros_ip_dhcp_server" "dhcp_server" {
  address_pool = routeros_ip_pool.dhcp.name
  interface    = routeros_interface_bridge.lan.name
  lease_time   = "6h"
  name         = "defconf"
  # Note: Not using dhcp_option_set - each client gets options via static lease
  # Parameter is omitted so Terraform doesn't manage it
}

# DHCP Server Network
resource "routeros_ip_dhcp_server_network" "lan" {
  address    = "192.168.20.0/24"
  dns_server = ["192.168.20.1"] # Use Mikrotik for DNS
  gateway    = "192.168.20.1"
  netmask    = 24

  # Note: NOT setting next_server or boot_file_name here (parameters completely omitted)
  # According to MikroTik docs, if these are present in the network definition,
  # DHCP options 66/67 won't work. We want to use option sets for per-client control.
  #
  # PXE boot settings are instead provided via:
  # - DHCP options (dhcp.options.tf)
  # - Option sets (dhcp.option-sets.tf)
  # - Static leases (dhcp.leases.tf) for specific MAC addresses

  comment = "defconf - PXE boot via DHCP option sets"
}

resource "routeros_ip_pool" "dhcp" {
  name   = "dhcp"
  ranges = ["192.168.20.90-192.168.20.180"]
}

resource "routeros_ip_dhcp_server" "dhcp_server" {
  address_pool = routeros_ip_pool.dhcp.name
  interface    = routeros_interface_bridge.lan.name
  lease_time   = "6h"
  name         = "defconf"
}

# DHCP Server Network
resource "routeros_ip_dhcp_server_network" "lan" {
  address        = "192.168.20.0/24"
  boot_file_name = "undionly.kpxe"
  dns_server     = ["192.168.20.200"]
  gateway        = "192.168.20.1"
  netmask        = 24
  next_server    = "192.168.20.200"
  comment        = "defconf"
}

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
  address = "192.168.20.0/24"
  # Default boot file (fallback if no matcher applies)
  # Using x86_64 UEFI as default since most modern systems are x86_64
  boot_file_name = "usb1-part2/boot/ipxe-x86_64.efi"
  dns_server     = ["192.168.20.1"] # Use Mikrotik for DNS
  gateway        = "192.168.20.1"
  netmask        = 24
  # Point to Mikrotik itself for TFTP/PXE
  next_server = "192.168.20.1"
  comment     = "defconf - Architecture-specific boot via matchers"
}

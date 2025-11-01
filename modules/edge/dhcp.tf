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

# DHCP Server Options for PXE Boot
resource "routeros_ip_dhcp_server_option" "boot_file_pxe_uefi" {
  name  = "boot-file-pxe-uefi"
  code  = 67
  value = "s'snponly.efi'"
}

resource "routeros_ip_dhcp_server_option" "boot_file_pxe_bios" {
  name  = "boot-file-pxe-bios"
  code  = 67
  value = "s'undionly.kpxe'"
}

resource "routeros_ip_dhcp_server_option" "next_server" {
  name  = "next-server"
  code  = 66
  value = "s'192.168.20.200'"
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
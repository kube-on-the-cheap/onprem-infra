resource "routeros_interface_bridge" "lan" {
  name      = "bridge"
  comment   = "The default LAN bridge interface"
  admin_mac = "F4:1E:57:EB:47:D7"
  auto_mac  = false
}

resource "routeros_ip_address" "lan" {
  address   = "192.168.20.1/24"
  interface = routeros_interface_bridge.lan.name
  network   = "192.168.20.0"
  comment   = "LAN interface"
}

resource "routeros_interface_list" "lan" {
  name    = "LAN"
  comment = "All LAN-facing interfaces"
}

resource "routeros_interface_list_member" "lan_bridge" {
  interface = routeros_interface_bridge.lan.name
  list      = routeros_interface_list.lan.name
}

locals {
  lan_interfaces = [ 
      routeros_interface_ethernet.ether2.name, 
      routeros_interface_ethernet.ether3.name, 
      routeros_interface_ethernet.ether4.name, 
      routeros_interface_ethernet.ether5.name, 
      routeros_interface_ethernet.ether6.name, 
      routeros_interface_ethernet.ether7.name, 
      routeros_interface_ethernet.ether8.name, 
      routeros_interface_ethernet.sfp-sfpplus1.name 
    ]
}

# Bridge ports - all LAN interfaces connected to the bridge
resource "routeros_interface_bridge_port" "lan_interfaces" {
  for_each  = toset(local.lan_interfaces)
  bridge    = routeros_interface_bridge.lan.name
  interface = each.value
  comment = "Interface ${each.value} belongs to the LAN bridge"
}

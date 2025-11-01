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
  lan_interfaces = concat(
    [ for x in range(2,9): format("ether%s",x) ],
    [ "sfp-sfpplus1" ]
  )
}

# Bridge ports - all LAN interfaces connected to the bridge
resource "routeros_interface_bridge_port" "lan_interfaces" {
  for_each  = toset(local.lan_interfaces)
  bridge    = routeros_interface_bridge.lan.name
  interface = each.value
  comment = "Interface ${each.value} belongs to the LAN bridge"
}

# INFO: for comparison, you can do the explicit format, but for the bridge assignment it doesn't make much sense
#
# resource "routeros_interface_bridge_port" "ether2" {
#   bridge    = routeros_interface_bridge.lan.name
#   interface = "ether2"
#   comment   = "defconf"
# }
#
# resource "routeros_interface_bridge_port" "ether3" {
#   bridge    = routeros_interface_bridge.lan.name
#   interface = "ether3"
#   comment   = "defconf"
# }

resource "routeros_interface_bridge" "lan" {
  name          = "bridge"
  comment       = "defconf"
  admin_mac     = "4C:5E:0C:F3:53:0B"
  auto_mac      = false
  protocol_mode = "none"
}

resource "routeros_ip_address" "lan" {
  address   = "192.168.20.11/24"
  interface = routeros_interface_bridge.lan.name
  network   = "192.168.20.0"
}

resource "routeros_interface_list" "lan" {
  name    = "LAN"
  comment = "All LAN-facing interfaces"
}

resource "routeros_interface_list" "wan" {
  name    = "WAN"
  comment = "defconf"
}

resource "routeros_interface_list_member" "wan_ether1" {
  interface = "ether1"
  list      = routeros_interface_list.wan.name
}

locals {
  lan_bridge_interfaces = concat(
    [for x in range(1, 11) : format("ether%s", x)],
    ["sfp1"]
  )

  lan_list_interfaces = concat(
    [for x in range(2, 11) : format("ether%s", x)],
    ["sfp1"]
  )
}

resource "routeros_interface_bridge_port" "lan_interfaces" {
  for_each  = toset(local.lan_bridge_interfaces)
  bridge    = routeros_interface_bridge.lan.name
  interface = each.value
  comment   = each.value == "ether1" ? "nondefconf" : "defconf"
  trusted   = each.value == "ether6" ? true : false
}

resource "routeros_interface_list_member" "lan_interfaces" {
  for_each  = toset(local.lan_list_interfaces)
  interface = each.value
  list      = routeros_interface_list.lan.name
}

resource "routeros_interface_list_member" "lan_bridge" {
  interface = routeros_interface_bridge.lan.name
  list      = routeros_interface_list.lan.name
}

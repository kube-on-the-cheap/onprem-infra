resource "routeros_ip_address" "lan" {
  address   = "192.168.20.1/24"
  interface = routeros_interface_bridge.lan.name
  network   = "192.168.20.0"
  comment   = "LAN interface"
}

resource "routeros_interface_bridge" "lan" {
  name      = "bridge"
  comment   = "The default LAN bridge interface"
  admin_mac = "F4:1E:57:EB:47:D7"
  auto_mac  = false
}

resource "routeros_interface_list" "lan" {
  name    = "LAN"
  comment = "defconf"
}

resource "routeros_interface_list_member" "lan_bridge" {
  interface = routeros_interface_bridge.lan.name
  list      = routeros_interface_list.lan.name
  comment   = "defconf"
}

# Bridge ports - all LAN interfaces connected to the bridge
resource "routeros_interface_bridge_port" "ether2" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "ether2"
  comment   = "defconf"
}

resource "routeros_interface_bridge_port" "ether3" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "ether3"
  comment   = "defconf"
}

resource "routeros_interface_bridge_port" "ether4" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "ether4"
  comment   = "defconf"
}

resource "routeros_interface_bridge_port" "ether5" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "ether5"
  comment   = "defconf"
}

resource "routeros_interface_bridge_port" "ether6" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "ether6"
  comment   = "defconf"
}

resource "routeros_interface_bridge_port" "ether7" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "ether7"
  comment   = "defconf"
}

resource "routeros_interface_bridge_port" "ether8" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "ether8"
  comment   = "defconf"
}

resource "routeros_interface_bridge_port" "sfp" {
  bridge    = routeros_interface_bridge.lan.name
  interface = "sfp-sfpplus1"
  comment   = "defconf"
}
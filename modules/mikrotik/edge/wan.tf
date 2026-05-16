variable "pppoe_credentials" {
  type = object({
    username = string
    password = string
  })
  description = "The PPPoE credentials (username and password) to use with the service"
}

resource "routeros_interface_pppoe_client" "wan" {
  name              = "pppoe-out1"
  interface         = "ether1"
  user              = var.pppoe_credentials.username
  password          = var.pppoe_credentials.password
  add_default_route = true
  use_peer_dns      = true
  disabled          = false
}

resource "routeros_interface_list" "wan" {
  name    = "WAN"
  comment = "All WAN-facing interfaces"
}

resource "routeros_interface_list_member" "wan_ether1" {
  interface = "ether1"
  list      = routeros_interface_list.wan.name
}

resource "routeros_interface_list_member" "wan_pppoe" {
  interface = routeros_interface_pppoe_client.wan.name
  list      = routeros_interface_list.wan.name
}

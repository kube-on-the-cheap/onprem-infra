resource "routeros_interface_ethernet" "ether1" {
  factory_name = "ether1"
  name         = "ether1"
  comment      = "To Eolo"
}
resource "routeros_interface_ethernet" "ether2" {
  factory_name = "ether2"
  name         = "ether2"
}
resource "routeros_interface_ethernet" "ether3" {
  factory_name = "ether3"
  name         = "ether3"
}
resource "routeros_interface_ethernet" "ether4" {
  factory_name = "ether4"
  name         = "ether4"
  comment      = "To SW-01"
}
resource "routeros_interface_ethernet" "ether5" {
  factory_name = "ether5"
  name         = "ether5"
}
resource "routeros_interface_ethernet" "ether6" {
  factory_name = "ether6"
  name         = "ether6"
  comment      = "To AP-01"
}
resource "routeros_interface_ethernet" "ether7" {
  factory_name = "ether7"
  name         = "ether7"
  comment      = "To AP-02"
}
resource "routeros_interface_ethernet" "ether8" {
  factory_name = "ether8"
  name         = "ether8"
  comment      = "To AP-03"
}
resource "routeros_interface_ethernet" "sfp-sfpplus1" {
  factory_name = "sfp-sfpplus1"
  name         = "sfp-sfpplus1"
}
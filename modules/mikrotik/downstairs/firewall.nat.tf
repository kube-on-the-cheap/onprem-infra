resource "routeros_ip_firewall_nat" "masquerade" {
  chain              = "srcnat"
  action             = "masquerade"
  ipsec_policy       = "out,none"
  out_interface_list = routeros_interface_list.wan.name
  comment            = "defconf: masquerade"
}

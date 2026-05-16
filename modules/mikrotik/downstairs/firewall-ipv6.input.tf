resource "routeros_ipv6_firewall_filter" "input_accept_established" {
  chain            = "input"
  action           = "accept"
  connection_state = "established,related,untracked"
  comment          = "defconf: accept established,related,untracked"
}

resource "routeros_ipv6_firewall_filter" "input_drop_invalid" {
  chain            = "input"
  action           = "drop"
  connection_state = "invalid"
  comment          = "defconf: drop invalid"
}

resource "routeros_ipv6_firewall_filter" "input_accept_icmpv6" {
  chain    = "input"
  action   = "accept"
  protocol = "icmpv6"
  comment  = "defconf: accept ICMPv6"
}

resource "routeros_ipv6_firewall_filter" "input_accept_udp_traceroute" {
  chain    = "input"
  action   = "accept"
  protocol = "udp"
  dst_port = "33434-33534"
  comment  = "defconf: accept UDP traceroute"
}

resource "routeros_ipv6_firewall_filter" "input_accept_dhcpv6" {
  chain       = "input"
  action      = "accept"
  protocol    = "udp"
  dst_port    = "546"
  src_address = "fe80::/10"
  comment     = "defconf: accept DHCPv6-Client prefix delegation."
}

resource "routeros_ipv6_firewall_filter" "input_accept_ike" {
  chain    = "input"
  action   = "accept"
  protocol = "udp"
  dst_port = "500,4500"
  comment  = "defconf: accept IKE"
}

resource "routeros_ipv6_firewall_filter" "input_accept_ipsec_ah" {
  chain    = "input"
  action   = "accept"
  protocol = "ipsec-ah"
  comment  = "defconf: accept ipsec AH"
}

resource "routeros_ipv6_firewall_filter" "input_accept_ipsec_esp" {
  chain    = "input"
  action   = "accept"
  protocol = "ipsec-esp"
  comment  = "defconf: accept ipsec ESP"
}

resource "routeros_ipv6_firewall_filter" "input_accept_ipsec_policy" {
  chain        = "input"
  action       = "accept"
  ipsec_policy = "in,ipsec"
  comment      = "defconf: accept all that matches ipsec policy"
}

resource "routeros_ipv6_firewall_filter" "input_drop_not_lan" {
  chain             = "input"
  action            = "drop"
  in_interface_list = "!LAN"
  comment           = "defconf: drop everything else not coming from LAN"
}

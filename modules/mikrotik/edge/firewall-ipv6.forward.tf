# IPv6 Firewall Filter Rules - Forward Chain
resource "routeros_ipv6_firewall_filter" "forward_accept_established" {
  chain            = "forward"
  action           = "accept"
  connection_state = "established,related,untracked"
  comment          = "defconf: accept established,related,untracked"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_invalid" {
  chain            = "forward"
  action           = "drop"
  connection_state = "invalid"
  comment          = "defconf: drop invalid"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_bad_src" {
  chain            = "forward"
  action           = "drop"
  src_address_list = "bad_ipv6"
  comment          = "defconf: drop packets with bad src ipv6"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_bad_dst" {
  chain            = "forward"
  action           = "drop"
  dst_address_list = "bad_ipv6"
  comment          = "defconf: drop packets with bad dst ipv6"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_hop_limit" {
  chain     = "forward"
  action    = "drop"
  protocol  = "icmpv6"
  hop_limit = "equal:1"
  comment   = "defconf: rfc4890 drop hop-limit=1"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_icmpv6" {
  chain    = "forward"
  action   = "accept"
  protocol = "icmpv6"
  comment  = "defconf: accept ICMPv6"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_hip" {
  chain    = "forward"
  action   = "accept"
  protocol = "139"
  comment  = "defconf: accept HIP"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ike" {
  chain    = "forward"
  action   = "accept"
  protocol = "udp"
  dst_port = "500,4500"
  comment  = "defconf: accept IKE"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ipsec_ah" {
  chain    = "forward"
  action   = "accept"
  protocol = "ipsec-ah"
  comment  = "defconf: accept ipsec AH"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ipsec_esp" {
  chain    = "forward"
  action   = "accept"
  protocol = "ipsec-esp"
  comment  = "defconf: accept ipsec ESP"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ipsec_policy" {
  chain        = "forward"
  action       = "accept"
  ipsec_policy = "in,ipsec"
  comment      = "defconf: accept all that matches ipsec policy"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_not_lan" {
  chain             = "forward"
  action            = "drop"
  in_interface_list = "!LAN"
  comment           = "defconf: drop everything else not coming from LAN"
}

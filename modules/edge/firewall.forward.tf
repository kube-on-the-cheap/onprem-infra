# IPv4 Firewall Filter Rules - Forward Chain
resource "routeros_ip_firewall_filter" "forward_accept_ipsec_in" {
  chain        = "forward"
  action       = "accept"
  ipsec_policy = "in,ipsec"
  comment      = "defconf: accept in ipsec policy"
}

resource "routeros_ip_firewall_filter" "forward_accept_ipsec_out" {
  chain        = "forward"
  action       = "accept"
  ipsec_policy = "out,ipsec"
  comment      = "defconf: accept out ipsec policy"
}

resource "routeros_ip_firewall_filter" "forward_fasttrack" {
  chain            = "forward"
  action           = "fasttrack-connection"
  connection_state = "established,related"
  hw_offload       = true
  comment          = "defconf: fasttrack"
}

resource "routeros_ip_firewall_filter" "forward_accept_established" {
  chain            = "forward"
  action           = "accept"
  connection_state = "established,related,untracked"
  comment          = "defconf: accept established,related, untracked"
}

resource "routeros_ip_firewall_filter" "forward_drop_invalid" {
  chain            = "forward"
  action           = "drop"
  connection_state = "invalid"
  comment          = "defconf: drop invalid"
}

resource "routeros_ip_firewall_filter" "forward_drop_wan_not_dstnat" {
  chain                = "forward"
  action               = "drop"
  connection_nat_state = "!dstnat"
  connection_state     = "new"
  in_interface_list    = "WAN"
  comment              = "defconf: drop all from WAN not DSTNATed"
}

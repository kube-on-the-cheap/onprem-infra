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

resource "routeros_ip_firewall_filter" "forward_accept_dns_recursor_udp" {
  chain              = "forward"
  action             = "accept"
  protocol           = "udp"
  dst_port           = "53"
  src_address        = "192.168.20.200"
  out_interface_list = routeros_interface_list.wan.name
  comment            = "Allow DNS from internal recursor"
}

resource "routeros_ip_firewall_filter" "forward_accept_dns_recursor_tcp" {
  chain              = "forward"
  action             = "accept"
  protocol           = "tcp"
  dst_port           = "53"
  src_address        = "192.168.20.200"
  out_interface_list = routeros_interface_list.wan.name
  comment            = "Allow DNS from internal recursor"
}

resource "routeros_ip_firewall_filter" "forward_drop_dns_udp" {
  chain              = "forward"
  action             = "drop"
  protocol           = "udp"
  dst_port           = "53"
  out_interface_list = routeros_interface_list.wan.name
  comment            = "Drop outbound DNS not from recursor"
}

resource "routeros_ip_firewall_filter" "forward_drop_dns_tcp" {
  chain              = "forward"
  action             = "drop"
  protocol           = "tcp"
  dst_port           = "53"
  out_interface_list = routeros_interface_list.wan.name
  comment            = "Drop outbound DNS not from recursor"
}

# Drop DoH via SNI matching on known providers
locals {
  doh_blocked_hosts = [
    "dns.google",
    "dns.google.com",
    "dns64.dns.google",
    "cloudflare-dns.com",
    "one.one.one.one",
    "1dot1dot1dot1.cloudflare-dns.com",
    "security.cloudflare-dns.com",
    "family.cloudflare-dns.com",
    "dns.quad9.net",
    "doh.opendns.com",
    "dns.adguard-dns.io",
    "dns.nextdns.io",
    "doh.mullvad.net",
    "dns.controld.com",
    "doh.dns.sb",
    "dns.twnic.tw",
    "doh.applied-privacy.net",
    "doh.cleanbrowsing.org",
    "dns.switch.ch",
  ]
}

resource "routeros_ip_firewall_filter" "forward_drop_doh" {
  for_each = toset(local.doh_blocked_hosts)

  chain              = "forward"
  action             = "drop"
  protocol           = "tcp"
  dst_port           = "443"
  tls_host           = each.value
  out_interface_list = routeros_interface_list.wan.name
  comment            = "Drop DoH: ${each.value}"
}

resource "routeros_ip_firewall_filter" "forward_drop_dot" {
  chain              = "forward"
  action             = "drop"
  protocol           = "tcp"
  dst_port           = "853"
  out_interface_list = routeros_interface_list.wan.name
  comment            = "Drop outbound DNS-over-TLS"
}

resource "routeros_ip_firewall_filter" "forward_drop_doq" {
  chain              = "forward"
  action             = "drop"
  protocol           = "udp"
  dst_port           = "853"
  out_interface_list = routeros_interface_list.wan.name
  comment            = "Drop outbound DNS-over-QUIC"
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

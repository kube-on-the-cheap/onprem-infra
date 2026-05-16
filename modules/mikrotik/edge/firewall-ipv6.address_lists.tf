# IPv6 Firewall Address Lists
resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_unspecified" {
  address = "::/128"
  list    = "bad_ipv6"
  comment = "defconf: unspecified address"
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_loopback" {
  address = "::1/128"
  list    = "bad_ipv6"
  comment = "defconf: lo"
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_site_local" {
  address = "fec0::/10"
  list    = "bad_ipv6"
  comment = "defconf: site-local"
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_ipv4_mapped" {
  address = "::ffff:0.0.0.0/96"
  list    = "bad_ipv6"
  comment = "defconf: ipv4-mapped"
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_ipv4_compat" {
  address = "::/96"
  list    = "bad_ipv6"
  comment = "defconf: ipv4 compat"
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_discard" {
  address = "100::/64"
  list    = "bad_ipv6"
  comment = "defconf: discard only "
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_documentation" {
  address = "2001:db8::/32"
  list    = "bad_ipv6"
  comment = "defconf: documentation"
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_orchid" {
  address = "2001:10::/28"
  list    = "bad_ipv6"
  comment = "defconf: ORCHID"
}

resource "routeros_ipv6_firewall_addr_list" "bad_ipv6_6bone" {
  address = "3ffe::/16"
  list    = "bad_ipv6"
  comment = "defconf: 6bone"
}

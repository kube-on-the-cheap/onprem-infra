# IPv4 Firewall Filter Rules - Input Chain
resource "routeros_ip_firewall_filter" "input_accept_established" {
  chain            = "input"
  action           = "accept"
  connection_state = "established,related,untracked"
  comment          = "defconf: accept established,related,untracked"
}

resource "routeros_ip_firewall_filter" "input_drop_invalid" {
  chain            = "input"
  action           = "drop"
  connection_state = "invalid"
  comment          = "defconf: drop invalid"
}

resource "routeros_ip_firewall_filter" "input_accept_icmp" {
  chain    = "input"
  action   = "accept"
  protocol = "icmp"
  comment  = "defconf: accept ICMP"
}

resource "routeros_ip_firewall_filter" "input_accept_loopback" {
  chain       = "input"
  action      = "accept"
  dst_address = "127.0.0.1"
  comment     = "defconf: accept to local loopback (for CAPsMAN)"
}

resource "routeros_ip_firewall_filter" "input_accept_tftp_pxe" {
  chain             = "input"
  action            = "accept"
  protocol          = "udp"
  dst_port          = "69"
  in_interface_list = routeros_interface_list.lan.name
  comment           = "Temporary: Allow TFTP for PXE boot"
}

resource "routeros_ip_firewall_filter" "input_drop_not_lan" {
  chain             = "input"
  action            = "drop"
  in_interface_list = "!LAN"
  comment           = "defconf: drop all not coming from LAN"
}

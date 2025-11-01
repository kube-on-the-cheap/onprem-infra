resource "routeros_ip_dns" "dns" {
  allow_remote_requests = true
}

resource "routeros_ip_dns_record" "router" {
  name    = "edge.caravhouse.local"
  address = "192.168.20.1"
  type    = "A"
  comment = "Name of the router"
}

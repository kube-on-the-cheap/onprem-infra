resource "routeros_ip_route" "default" {
  dst_address = "0.0.0.0/0"
  gateway     = "192.168.20.1"
}

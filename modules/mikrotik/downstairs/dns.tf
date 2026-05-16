resource "routeros_ip_dns" "dns" {
  allow_remote_requests = true
  servers               = ["192.168.20.200"]
}

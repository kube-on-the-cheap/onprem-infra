resource "routeros_system_clock" "clock" {
  time_zone_name = "Europe/Rome"
}

resource "routeros_system_ntp_client" "ntp" {
  enabled = true
  servers = ["ntp1.ien.it"]
}

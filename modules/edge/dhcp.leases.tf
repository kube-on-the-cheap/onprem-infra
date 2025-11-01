resource "routeros_ip_dhcp_server_lease" "dietpi" {
  address     = "192.168.20.200"
  mac_address = "B8:27:EB:EB:45:C2"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "DietPi"
}

resource "routeros_ip_dhcp_server_lease" "nasser" {
  address     = "192.168.20.16"
  mac_address = "B0:5A:DA:87:4A:D0"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "NASser"
}

resource "routeros_ip_dhcp_server_lease" "nas" {
  address     = "192.168.20.15"
  mac_address = "00:11:32:46:96:EB"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "NAS"
}

resource "routeros_ip_dhcp_server_lease" "simpleton" {
  address     = "192.168.20.111"
  mac_address = "42:AE:F3:F6:27:FF"
  # client_id   = "1:42:ae:f3:f6:27:ff"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "simpleton"
}

resource "routeros_ip_dhcp_server_lease" "rainbowparty" {
  address     = "192.168.20.125"
  mac_address = "3C:7C:3F:1D:81:66"
  # client_id   = "1:3c:7c:3f:1d:81:66"
  server      = routeros_ip_dhcp_server.dhcp_server.name
  comment     = "RainbowParty"
}

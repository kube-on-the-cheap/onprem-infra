# System Note Configuration
resource "routeros_system_note" "note" {
  show_at_login = true
  note = <<-EOT
    ╔════════════════════════════════════════════════╗
    ║         MikroTik Edge Router                   ║
    ║         Unauthorized access prohibited         ║
    ╚════════════════════════════════════════════════╝

    WARNING: This system is for authorized use only.
    All activity is logged and monitored.

    Configuration managed by Terraform - manual changes
    may be overwritten. See: onprem-infra repository
  EOT
}

# SSH Configuration
resource "routeros_ip_ssh_server" "ssh" {
  host_key_size = 4096
  host_key_type = "ed25519"
  strong_crypto = true
}

# MAC Server Configuration
resource "routeros_tool_mac_server" "mac_server" {
  allowed_interface_list = routeros_interface_list.lan.name
}

resource "routeros_tool_mac_server_winbox" "mac_winbox" {
  allowed_interface_list = routeros_interface_list.lan.name
}

# Disk Settings
resource "routeros_disk_settings" "disk" {
  auto_media_interface = routeros_interface_bridge.lan.name
  auto_media_sharing   = true
  auto_smb_sharing     = true
}

# IP Neighbor Discovery Settings
resource "routeros_ip_neighbor_discovery_settings" "discovery" {
  discover_interface_list = routeros_interface_list.lan.name
}

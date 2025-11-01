# NOTE: open question, does it make sense to have static passwords for these users? Perhaps when I'll have a central identity...

# --- Admin User ---
resource "routeros_system_user" "admin" {
  name     = "admin"
  group    = "full"
  comment  = "Administrator account"
  disabled = false
}

resource "routeros_system_user_sshkeys" "admin_key" {
  user    = routeros_system_user.admin.name
  key     = var.admin_ssh_public_key
  comment = "Admin SSH public key"
}

# --- Terraform Admin User ---
resource "routeros_system_user" "tfadmin" {
  name     = "tfadmin"
  group    = "full"
  comment  = "Terraform User"
  address  = "192.168.20.0/24"
  disabled = false
}
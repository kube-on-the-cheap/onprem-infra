# NOTE: open question, does it make sense to have static passwords for these users? Perhaps when I'll have a central identity...

# --- Admin User ---
resource "routeros_system_user" "admin" {
  name     = "admin"
  group    = "full"
  comment  = "Administrator account"
  disabled = false
}

variable "admin_ssh_public_key" {
  description = <<-EOT
    SSH public key for admin user authentication.
    Must be in OpenSSH public key format starting with 'ssh-rsa' or 'ssh-ed25519'.
    Example: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6... user@host'

    Note: RouterOS 7.7+ required for ed25519 keys. RSA keys are most compatible.
    Generate with: ssh-keygen -t rsa -b 4096
  EOT
  type        = string
  sensitive   = true
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

# --- Home Assitant User and Group ---
variable "home_assistant_credentials" {
  description = "Credentials for the Home Assistant API user."
  type = object({
    username = string
    password = string
  })
  sensitive = true
}

resource "routeros_system_user_group" "homeassistant" {
  name   = "homeassistant"
  policy = ["read", "api", "test"]
}

resource "routeros_system_user" "homeassistant" {
  name     = var.home_assistant_credentials.username
  password = var.home_assistant_credentials.password
  group    = routeros_system_user_group.homeassistant.name
  disabled = false
}

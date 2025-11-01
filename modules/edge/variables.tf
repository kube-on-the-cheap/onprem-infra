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

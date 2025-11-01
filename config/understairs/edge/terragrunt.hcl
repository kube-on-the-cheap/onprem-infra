terraform {
  source = "../../..//modules/edge/"

  extra_arguments "provider_config" {
    commands = ["plan", "apply", "refresh", "import"]
    env_vars = {
      MIKROTIK_HOST = "http://192.168.20.1"
      MIKROTIK_USER = local.mikrotik_credentials.username
      MIKROTIK_PASSWORD = local.mikrotik_credentials.password
      MIKROTIK_INSECURE = true
    }
  }
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

locals {
  mikrotik_credentials = yamldecode(sops_decrypt_file("./mikrotik_credentials.sops.yaml"))
}

inputs = {
  admin_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKuPV6H09Xnq05D3+kfJNVBKKZqXIB5+lGaYvg3Htuc marco@simpleton"
  pppoe_credentials = yamldecode(sops_decrypt_file("./pppoe_credentials.sops.yaml"))
}

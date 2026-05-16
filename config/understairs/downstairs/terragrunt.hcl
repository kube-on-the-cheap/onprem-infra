terraform {
  source = "../../..//modules/mikrotik/downstairs/"

  extra_arguments "provider_config" {
    commands = ["plan", "apply", "refresh", "import"]
    env_vars = {
      MIKROTIK_HOST     = "http://192.168.20.11"
      MIKROTIK_USER     = local.tg_credentials.username
      MIKROTIK_PASSWORD = local.tg_credentials.password
      MIKROTIK_INSECURE = true
    }
  }
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

locals {
  tg_credentials   = yamldecode(sops_decrypt_file("./tg_credentials.sops.yaml"))
  hass_credentials = yamldecode(sops_decrypt_file("./hass_credentials.sops.yaml"))
}

inputs = {
  admin_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKuPV6H09Xnq05D3+kfJNVBKKZqXIB5+lGaYvg3Htuc marco@simpleton"
  home_assistant_credentials = {
    username = local.hass_credentials.username
    password = local.hass_credentials.password
  }
}

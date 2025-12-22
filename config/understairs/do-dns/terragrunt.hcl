terraform {
  source = "../../..//modules/do-dns"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

inputs = {
  # Cloudflare zone
  domain_name = "blacksd.tech"
  # DigitalOcean project
  project_name       = "Kube, on the cheap"
  onprem_domain_name = "homelab.blacksd.tech"
}

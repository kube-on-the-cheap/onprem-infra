terraform {
  source = "../../..//modules/platform-bootstrap/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

locals {
  age_key = join("",[ for line in split("\n",sops_decrypt_file("./age.agekey.sops")): line if ! startswith(line, "#") ])
}

inputs = {
  flux_version = "2.5.x"
  sync = {
    repo = "https://github.com/kube-on-the-cheap/platform"
    path = "clusters/understairs"
  }
  secret_key = local.age_key
}

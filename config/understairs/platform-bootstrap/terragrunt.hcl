terraform {
  source = "../../..//modules/platform-bootstrap/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

locals {
  age_key = join("", [for line in split("\n", sops_decrypt_file("./understairs.agekey.sops")) : line if !startswith(line, "#")])
}

inputs = {
  flux_version          = "2.8.x"
  flux_operator_version = "0.47.0"
  cilium_version        = "1.18.5"
  cluster_name          = "understairs"
  sync = {
    repo = "https://github.com/kube-on-the-cheap/platform"
    path = "clusters/understairs"
  }
  secret_key = local.age_key
}

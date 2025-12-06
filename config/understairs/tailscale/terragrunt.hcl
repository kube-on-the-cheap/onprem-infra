terraform {
  source = "../../..//modules/tailscale/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

inputs = {
  oauth_client_name = "understairs"
  oauth_client_tags = ["tag:onprem"]
}

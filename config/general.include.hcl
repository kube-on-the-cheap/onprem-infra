remote_state {
  backend      = "gcs"
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))
  config = {
    bucket   = format("%s-onprem-%s", local.gcp.project_id, "m3c01on1") # INFO: We need a globally unique bucket name, and we don't have the neat AWS get_caller_id function available for GCP
    prefix   = format("%s/terraform.tfstate", path_relative_to_include())
    project  = local.gcp.project_id
    location = local.gcp.region
  }
}

locals {
  project_details = {
    name       = "Kube, on the cheap"
    tagline    = "A lab project for the parsimonious Kubernetes administrator"
    short_form = "kube-on-the-cheap"
  }
  gcp = {
    region     = "europe-west3"
    project_id = local.project_details.short_form
  }
  domain_name = "blacksd.tech"
}

inputs = {
}

terraform_version_constraint  = "~> 1.10.0"
terragrunt_version_constraint = "~> 0.71.0"

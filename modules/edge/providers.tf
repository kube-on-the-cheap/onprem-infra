terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
      version = "1.89.0"
    }
  }
  backend "gcs" {}
}

provider "routeros" {
}
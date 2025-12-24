variable "domain_name" {
  description = "The parent OCI domain name"
}

variable "onprem_domain_name" {
  description = "The domain used to host onprem resources"
}

resource "digitalocean_domain" "onprem" {
  name = var.onprem_domain_name

  lifecycle {
    precondition {
      condition     = strcontains(var.onprem_domain_name, var.domain_name)
      error_message = "The onprem domain must be part of the parent domain."
    }
  }
}

data "digitalocean_records" "onprem_ns" {
  domain = digitalocean_domain.onprem.name
  filter {
    key    = "type"
    values = ["NS"]
  }
}

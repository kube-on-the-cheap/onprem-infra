variable "secret_name" {
  description = "The name of the Kubernetes secret to create"
  type        = string
  default     = "tailscale-oauth"
}

variable "oauth_client_name" {
  description = "Description for the Tailscale OAuth client"
  type        = string
}

locals {
  oauth_client_scopes = ["devices:core", "auth_keys"]
}

variable "oauth_client_tags" {
  description = "Tags that the OAuth client can assign to devices"
  type        = list(string)
}

variable "namespace" {
  description = "The Kubernetes namespace to create the secret in"
  type        = string
  default     = "tailscale"
}

resource "tailscale_oauth_client" "this" {
  description = "OAuth client for ${var.oauth_client_name}"
  scopes      = local.oauth_client_scopes
  tags        = var.oauth_client_tags
}

resource "kubernetes_namespace" "tailscale" {
  metadata {
    annotations = {
      "blacksd.tech/repo" = "github.com/onprem-infra"
    }

    name = var.namespace
  }
}

resource "kubernetes_secret" "tailscale_oauth" {
  metadata {
    name      = var.secret_name
    namespace = kubernetes_namespace.tailscale.metadata[0].name
    annotations = {
      "blacksd.tech/repo" = "github.com/onprem-infra"
    }
  }

  data = {
    client_id     = tailscale_oauth_client.this.id
    client_secret = tailscale_oauth_client.this.key
  }

  type = "Opaque"
}

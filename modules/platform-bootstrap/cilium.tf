variable "cilium_version" {
  description = "The version of Cilium to install"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

resource "helm_release" "cilium" {
  name       = "cilium"
  namespace  = "kube-system"
  repository = "https://helm.cilium.io"

  chart   = "cilium"
  version = var.cilium_version

  values = [
    templatefile("${path.module}/templates/cilium-values.yaml.tftpl", {
      cluster_name = var.cluster_name
    })
  ]

  lifecycle {
    precondition {
      condition     = one(data.kubernetes_namespace.kube_system.metadata.*.uid) != null
      error_message = "Unable to get the kube-system namespace. Check the connection to the API Server and/or the permissions for the user in your kubeconfig."
    }
    # Ignore changes after initial creation - let Flux manage it
    ignore_changes = [
      values,
      version
    ]
  }
}

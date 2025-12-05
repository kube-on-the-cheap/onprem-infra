terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3"
    }
  }
  backend "gcs" {}
}

provider "kubernetes" {
}

provider "helm" {
}

data "kubernetes_namespace" "kube_system" {
  metadata {
    name = "kube-system"
  }
}

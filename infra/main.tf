terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

provider "kubernetes" {
  # Use the kubeconfig that k3d wrote. Adjust if your kubeconfig path is different.
  config_path = "~/.kube/config"
}

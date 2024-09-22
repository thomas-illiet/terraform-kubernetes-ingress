terraform {
  required_version = ">= 1.2.5"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
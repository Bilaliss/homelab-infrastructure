terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

# Namespace
resource "kubernetes_namespace" "homelab" {
  metadata {
    name = var.namespace_name
  }
}

# Deployment Nginx (esempio)
resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-tf"
    namespace = kubernetes_namespace.homelab.metadata[0].name
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "nginx-tf"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-tf"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-tf"
    namespace = kubernetes_namespace.homelab.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx-tf"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30081
    }

    type = "NodePort"
  }
}

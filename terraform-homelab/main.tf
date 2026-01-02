terraform {
  required_version = ">= 1.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

# Provider Docker
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Provider Kubernetes
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Network Docker
resource "docker_network" "homelab" {
  name = "homelab-network"
}

# Nextcloud
resource "docker_container" "nextcloud" {
  name  = "nextcloud-tf"
  image = docker_image.nextcloud.image_id

  networks_advanced {
    name = docker_network.homelab.name
  }

  ports {
    internal = 80
    external = 8081
  }

  volumes {
    host_path      = "/home/bilalis/k8s-data/nextcloud"
    container_path = "/var/www/html/data"
  }

  restart = "unless-stopped"
}

resource "docker_image" "nextcloud" {
  name = "nextcloud:latest"
}

# Vaultwarden
resource "docker_container" "vaultwarden" {
  name  = "vaultwarden-tf"
  image = docker_image.vaultwarden.image_id

  networks_advanced {
    name = docker_network.homelab.name
  }

  ports {
    internal = 80
    external = 8091
  }

  volumes {
    host_path      = "/home/bilalis/vaultwarden/data"
    container_path = "/data"
  }

  env = [
    "WEBSOCKET_ENABLED=true",
    "SIGNUPS_ALLOWED=true"
  ]

  restart = "unless-stopped"
}

resource "docker_image" "vaultwarden" {
  name = "vaultwarden/server:latest"
}
module "kubernetes" {
  source = "./modules/kubernetes"
  
  namespace_name = "homelab-tf"
  replicas       = 1
}


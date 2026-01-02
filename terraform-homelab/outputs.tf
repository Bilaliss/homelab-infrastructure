output "nextcloud_url" {
  description = "Nextcloud access URL"
  value       = "http://192.168.1.12:${var.nextcloud_port}"
}

output "vaultwarden_url" {
  description = "Vaultwarden access URL"
  value       = "http://192.168.1.12:${var.vaultwarden_port}"
}

output "network_name" {
  description = "Docker network name"
  value       = docker_network.homelab.name
}

output "containers" {
  description = "Deployed containers"
  value = {
    nextcloud   = docker_container.nextcloud.name
    vaultwarden = docker_container.vaultwarden.name
  }
}
output "k8s_namespace" {
  description = "Kubernetes namespace"
  value       = module.kubernetes.namespace
}

output "nginx_url" {
  description = "Nginx service URL"
  value       = module.kubernetes.nginx_url
}

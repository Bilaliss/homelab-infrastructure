output "namespace" {
  value = kubernetes_namespace.homelab.metadata[0].name
}

output "nginx_url" {
  value = "http://192.168.1.12:30081"
}

variable "namespace_name" {
  description = "Kubernetes namespace"
  type        = string
  default     = "homelab-tf"
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
  default     = 1
}

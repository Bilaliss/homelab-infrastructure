variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "homelab_network_name" {
  description = "Docker network name"
  type        = string
  default     = "homelab-network"
}

variable "nextcloud_port" {
  description = "Nextcloud external port"
  type        = number
  default     = 8081
}

variable "vaultwarden_port" {
  description = "Vaultwarden external port"
  type        = number
  default     = 8091
}

variable "data_path" {
  description = "Base path for data storage"
  type        = string
  default     = "/home/bilalis/k8s-data"
}

variable "cluster_name" {
  description = "Назва EKS кластера"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN EKS OIDC провайдера для IRSA"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL EKS OIDC провайдера"
  type        = string
}
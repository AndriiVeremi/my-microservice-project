variable "name" {
  description = "Назва Helm-релізу"
  type        = string
  default     = "argo-cd"
}

variable "namespace" {
  description = "K8s namespace для Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Версія Argo CD чарта"
  type        = string
  default     = "5.46.4" 
}

variable "cluster_name" {
  description = "Ім'я EKS-кластера для підключення Helm"
  type        = string
}

variable "oidc_provider_arn" {
  description = "Провайдера arn для IRSA"
  type        = string
}

variable "oidc_provider_url" {
  description = "Провайдера url для IRSA"
  type        = string
}
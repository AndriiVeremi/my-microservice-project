variable "repository_name" {
  description = "Назва ECR репозиторію"
  type        = string
}

variable "scan_on_push" {
  description = "Сканувати образи при завантаженні"
  type = bool
}

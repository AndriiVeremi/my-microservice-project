variable "region" {
  description = "AWS регіон для розгортання"
  type        = string
  default     = "ap-southeast-1"
}

variable "cluster_name" {
  description = "Назва EKS кластера"
  type        = string
}

variable "subnet_ids" {
  description = "Список ID підмереж для EKS кластера"
  type        = list(string)
}

variable "instance_type" {
  description = "Тип EC2 інстансів для робочих вузлів"
  type        = string
  default     = "t3.medium"
}

variable "desired_size" {
  description = "Бажана кількість робочих вузлів"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Максимальна кількість робочих вузлів"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "Мінімальна кількість робочих вузлів"
  type        = number
  default     = 1
}

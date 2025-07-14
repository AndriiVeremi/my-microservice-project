variable "vpc_cidr_block" {
  description = "CIDR блок для VPC"
  type = string
}

variable "public_subnets" {
  description = "Список публічних підмереж"
  type = list(string)
}

variable "private_subnets" {
  description = "Список приватних підмереж"
  type = list(string)
}

variable "availability_zones" {
  description = "Список зон доступності"
  type = list(string)
}

variable "vpc_name" {
  description = "Назва VPC"
  type = string
}

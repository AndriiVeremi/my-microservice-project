variable "name" {
  description = "Ім’я бази"
  type        = string
}

variable "use_aurora" {
  description = "true — створюємо сluster"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Тип бази"
  type        = string
}
variable "engine_version" {
  description = "Версія RDS"
  type        = string
}
variable "engine_cluster" {
  description = "Тип Aurora"
  type        = string
}
variable "engine_version_cluster" {
  description = "Версія Aurora"
  type        = string
}

variable "instance_class" {
  description = "Клас інстансу"
  type        = string
}
variable "allocated_storage" {
  description = "Обсяг сховища (ГБ)"
  type        = number
  default     = 20
}

variable "subnet_private_ids" {
  description = "Id приватних підмереж"
  type        = list(string)
}

variable "subnet_public_ids" {
  description = "Iв публічних підмереж"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "true — буде ДБ публічною"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "true — ДБ буде в кількох зонах доступності"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Період зберігання"
  type        = number
  default     = 7
}

variable "parameters" {
  description = "Карта додаткових параметрів"
  type        = map(string)
  default     = {}
}

variable "aurora_replica_count" {
  description = "Кількість реплік"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Теги"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Id VPC"
  type        = string
}

variable "db_name" {
  description = "Назва ДБ"
  type        = string
}

variable "username" {
  description = "Ім'я користувача ДБ"
  type        = string
}

variable "password" {
  description = "Пароль ДБ"
  type        = string
  sensitive   = true
}
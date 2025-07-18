output "s3_bucket" {
  description = "S3 бакет для стану Terraform"
  value       = module.s3_backend.bucket_name
}

output "dynamodb_table" {
  description = "Таблиця DynamoDB для блокування стану"
  value       = module.s3_backend.table_name
}

output "vpc_id" {
  description = "ID VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "ID публічних підмереж"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "ID приватних підмереж"
  value       = module.vpc.private_subnets
}

output "ecr_repo_url" {
  description = "URL-адреса репозиторію ECR"
  value       = module.ecr.repository_url
}

output "eks_cluster_name" {
  description = "Ім'я кластера EKS"
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "Кінцева точка API EKS"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_ca" {
  description = "Центр сертифікації кластера EKS"
  value       = module.eks.eks_cluster_ca
}

output "argo_cd_url" {
  description = "URL-адреса Argo CD"
  value       = module.argo_cd.url
}

output "argo_cd_password" {
  description = "Початковий пароль адміністратора Argo CD"
  value       = module.argo_cd.password
  sensitive   = true
}

output "jenkins_url" {
  description = "URL-адреса Jenkins"
  value       = module.jenkins.url
}

output "jenkins_password" {
  description = "Початковий пароль адміністратора Jenkins"
  value       = module.jenkins.password
  sensitive   = true
}
provider "aws" {
  region = "eu-north-1"
}

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "dashuk-terraform-state-lesson5-${random_id.suffix.hex}"
  table_name  = "dashuk-terraform-locks"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones = ["eu-north-1a", "eu-north-1b"]
  vpc_name           = "lesson-5-vpc-dashuk"
}

resource "random_id" "suffix" {
  byte_length = 8
}

module "ecr" {
  source           = "./modules/ecr"
  repository_name  = "dashuk-ecr-lesson5"
  scan_on_push = true
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "dashuk-eks-lesson5"
  subnet_ids   = module.vpc.public_subnets_ids

  tags = {
    Name    = "Dashuk EKS Cluster"
    Project = "Lesson 5"
  }
}

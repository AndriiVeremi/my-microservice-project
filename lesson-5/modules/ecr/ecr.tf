resource "aws_ecr_repository" "this" {
  name = var.repository_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "Dashuk ECR Repo"
    Project = "Lesson 5"
  }
}
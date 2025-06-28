terraform {
  backend "s3" {
    bucket         = "dashuk-terraform-state-lesson5"
    key            = "lesson-5/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "dashuk-terraform-locks"
    encrypt        = true
  }
}
# Lesson-5 Terraform Project

Цей проєкт налаштовує інфраструктуру на AWS у регіоні eu-north-1 за допомогою Terraform.

## Структура проєкту
- `main.tf`: Підключення модулів S3, VPC, ECR.
- `backend.tf`: Налаштування S3-бекенду та DynamoDB для блокування.
- `outputs.tf`: Вихідні дані інфраструктури.
- `modules/`: Модулі для S3, VPC, ECR.

## Модулі
1. **s3-backend**: Створює S3-бакет для стейтів і DynamoDB для блокування.
2. **vpc**: Налаштовує VPC із публічними та приватними підмережами, Internet Gateway, NAT Gateway.
3. **ecr**: Створює ECR-репозиторій із скануванням образів.

## Використання
1. Встановіть Terraform.
2. Налаштуйте AWS CLI із доступом до регіону eu-north-1.
3. Виконайте:
   ```bash
   terraform init
   terraform plan
   terraform apply

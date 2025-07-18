# DevOps CI/CD навчальний проєкт

Цей репозиторій містить інфраструктурний код та налаштування для розгортання веб-додатку Django в Kubernetes. Проєкт демонструє повний цикл CI/CD, включаючи створення інфраструктури за допомогою Terraform, збірку Docker-образів у Jenkins та безперервне розгортання за допомогою Argo CD.

## Архітектура

Проєкт складається з таких компонентів:

-   **Terraform**: для створення базової інфраструктури в AWS (VPC, EKS, ECR, S3, DynamoDB, RDS).
-   **Docker**: для контейнеризації Django-додатку.
-   **Jenkins**: для автоматизації збірки та тестування.
-   **Helm**: для пакування Kubernetes-додатку.
-   **Argo CD**: для безперервного розгортання в Kubernetes.
-   **AWS RDS**: для створення та управління реляційною базою даних.

## Покрокова інструкція з розгортання

### Крок 1: Створення інфраструктури за допомогою Terraform

На цьому етапі ми створюємо всю необхідну інфраструктуру в AWS.

**Дії:**


1.  Перейдіть до директорії `lesson-5`:
    ```bash
    cd lesson-5
    ```

2.  Ініціалізуйте Terraform. Ця команда завантажить необхідні провайдери та модулі.
    ```bash
    terraform init
    ```

3.  Створіть план виконання. Ви побачите, які ресурси Terraform планує створити.
    ```bash
    terraform plan
    ```

4.  Застосуйте зміни для створення інфраструктури.
    ```bash
    terraform apply --auto-approve
    ```

**Перевірка:**

-   **Перевірка в AWS Console:**
    -   Перейдіть до консолі AWS.
    -   Переконайтеся, що створено новий VPC, EKS-кластер, ECR-репозиторій, S3-бакет, таблицю DynamoDB та базу даних RDS.
-   **Перевірка за допомогою AWS CLI:**
    ```bash
    # Перевірка EKS-кластера
    aws eks --region eu-north-1 describe-cluster --name <YOUR_CLUSTER_NAME>

    # Перевірка ECR-репозиторію
    aws ecr --region eu-north-1 describe-repositories --repository-names <YOUR_REPO_NAME>
    
    # Перевірка бази даних RDS
    aws rds --region eu-north-1 describe-db-instances --db-instance-identifier <YOUR_DB_INSTANCE_NAME>
    ```
    (Замініть `<YOUR_CLUSTER_NAME>`, `<YOUR_REPO_NAME>` та `<YOUR_DB_INSTANCE_NAME>` на реальні імена з ваших Terraform-змінних).

### Крок 2: Налаштування Jenkins та Argo CD

На цьому етапі ми розгортаємо Jenkins та Argo CD у наш EKS-кластер.

**Дії:**

1.  Terraform автоматично розгорне Jenkins та Argo CD за допомогою Helm-чартів, які вказані в модулях `jenkins` та `argo_cd`.

**Перевірка:**

-   **Перевірка в Kubernetes:**
    ```bash
    # Перевірка, чи запущені поди Jenkins та Argo CD
    kubectl get pods -n jenkins
    kubectl get pods -n argocd
    ```
-   **Доступ до Jenkins та Argo CD:**
    -   Знайдіть інструкції для доступу до Jenkins та Argo CD у вихідних даних Terraform (`terraform output`).
    -   Відкрийте їх у браузері та переконайтеся, що вони працюють.

### Крок 3: Збірка Docker-образу в Jenkins

На цьому етапі Jenkins автоматично збирає Docker-образ нашого Django-додатку та завантажує його в ECR.

**Дії:**

1.  Запустіть Jenkins-пайплайн (зазвичай він запускається автоматично після коміту в репозиторій).

**Перевірка:**

-   **Перевірка в Jenkins:**
    -   Відкрийте Jenkins.
    -   Перейдіть до пайплайну `django-app-pipeline`.
    -   Переконайтеся, що остання збірка успішно завершилася. Перегляньте логи, щоб побачити кроки збірки та завантаження в ECR.
-   **Перевірка в ECR:**
    -   Перейдіть до вашого ECR-репозиторію в AWS Console.
    -   Переконайтеся, що з'явився новий Docker-образ з останнім тегом.

### Крок 4: Розгортання в Kubernetes за допомогою Argo CD

На цьому етапі Argo CD автоматично розгортає наш додаток у Kubernetes, використовуючи оновлений Docker-образ.

**Дії:**

1.  Argo CD автоматично виявить зміни в репозиторії (новий Docker-образ) і запустить процес синхронізації.

**Перевірка:**

-   **Перевірка в Argo CD:**
    -   Відкрийте Argo CD.
    -   Знайдіть додаток `django-chart`.
    -   Переконайтеся, що його статус `Healthy` та `Synced`.
    -   Натисніть на додаток, щоб побачити всі розгорнуті ресурси (Deployment, Service, Pods).
-   **Перевірка в Kubernetes:**
    ```bash
    # Перевірка, чи запущено под з Django-додатком
    kubectl get pods -n <YOUR_APP_NAMESPACE>

    # Перевірка логів додатку
    kubectl logs -f <YOUR_POD_NAME> -n <YOUR_APP_NAMESPACE>
    ```
-   **Доступ до додатку:**
    -   Знайдіть зовнішню IP-адресу або DNS-ім'я вашого сервісу (зазвичай LoadBalancer).
    -   Відкрийте цю адресу в браузері. Ви повинні побачити сторінку Django.

## Модуль RDS

Модуль `rds` відповідає за створення бази даних AWS RDS. Він підтримує як звичайні екземпляри RDS, так і кластери Aurora.

### Приклад використання

```hcl
module "rds" {
   source = "./modules/rds"

   name            = "dashuk-rds-lesson5"
   use_aurora      = false

   engine          = "postgres"
   engine_version  = "13.7"
   instance_class  = "db.t3.micro"
   allocated_storage = 20
   db_name         = "dashuk_db_lesson5"
   username        = "postgres"
   password        = "admin"

   vpc_id          = module.vpc.vpc_id
   subnet_private_ids = module.vpc.private_subnets
   publicly_accessible = false
   multi_az         = false
   backup_retention_period = 7
   tags           = {
     Environment = "dev"
     Project     = "dashuk-lesson5"
   }
}
```

### Опис змінних

| Змінна | Опис | Тип | Значення за замовчуванням |
| --- | --- | --- | --- |
| `name` | Унікальне ім’я бази або кластера | `string` | - |
| `use_aurora` | Якщо `true` — створюємо Aurora Cluster, інакше — просту RDS | `bool` | `false` |
| `engine` | Тип бази (postgres, mysql) | `string` | - |
| `engine_version` | Версія движка для RDS | `string` | - |
| `engine_cluster` | Тип движка для Aurora (aurora-postgresql, aurora-mysql) | `string` | - |
| `engine_version_cluster` | Версія движка для Aurora | `string` | - |
| `instance_class` | Клас інстансу (db.t3.micro, db.t3.medium тощо) | `string` | - |
| `allocated_storage` | Обсяг сховища (ГБ) для звичайної RDS | `number` | `20` |
| `db_name` | Назва бази даних | `string` | - |
| `username` | Ім'я користувача для доступу до бази даних | `string` | - |
| `password` | Пароль для доступу до бази даних | `string` | - |
| `vpc_id` | ID віртуальної приватної мережі (VPC) | `string` | - |
| `subnet_private_ids` | Список ID приватних підмереж | `list(string)` | - |
| `subnet_public_ids` | Список ID публічних підмереж | `list(string)` | - |
| `publicly_accessible` | Визначає, чи буде база даних публічно доступною | `bool` | `false` |
| `multi_az` | Визначає, чи буде база даних розгорнута в кількох зонах доступності | `bool` | `false` |
| `backup_retention_period` | Період зберігання резервних копій (у днях) | `number` | `7` |
| `parameters` | Карта додаткових параметрів для групи параметрів | `map(string)` | `{}` |
| `aurora_replica_count` | Кількість read-only реплік для Aurora | `number` | `1` |
| `tags` | Теги, що ляжуть на всі ресурси | `map(string)` | `{}` |
| `skip_final_snapshot` | Пропустити фінальний знімок при видаленні | `bool` | `true` |

### Як змінити тип БД, engine, клас інстансу

Щоб змінити параметри бази даних, вам потрібно відредагувати виклик модуля `rds` у файлі `lesson-5/main.tf`.

-   **Зміна типу БД (RDS або Aurora):**
    -   Для використання **RDS**, встановіть `use_aurora = false`.
    -   Для використання **Aurora**, встановіть `use_aurora = true`.

-   **Зміна движка (engine):**
    -   Для **RDS** використовуйте змінну `engine` (наприклад, `"postgres"`) та `engine_version` (наприклад, `"13.7"`).
    -   Для **Aurora** використовуйте `engine_cluster` (наприклад, `"aurora-postgresql"`) та `engine_version_cluster` (наприклад, `"15.3"`).

-   **Зміна класу інстансу:**
    -   Змініть значення змінної `instance_class` на потрібний вам тип (наприклад, `"db.t3.large"`).

## Процес CI/CD

Цей проєкт використовує Jenkins та Argo CD для реалізації безперервної інтеграції та безперервного розгортання (CI/CD).

### Як застосувати зміни в Terraform

Якщо ви змінили інфраструктурний код (наприклад, додали новий ресурс або змінили параметри існуючого), вам потрібно виконати такі кроки:

1.  **Створіть план змін:**
    ```bash
    terraform plan
    ```
    Ця команда покаже, які зміни Terraform планує внести до вашої інфраструктури. Уважно перегляньте цей план.

2.  **Застосуйте зміни:**
    ```bash
    terraform apply --auto-approve
    ```
    Ця команда застосує зміни до вашої інфраструктури в AWS.

### Як перевірити Jenkins job

Jenkins автоматично запускає збірку при кожному коміті в основну гілку репозиторію. Щоб перевірити статус збірки:

1.  **Відкрийте Jenkins:** Знайдіть URL-адресу та пароль у вихідних даних Terraform (`terraform output`).
2.  **Знайдіть пайплайн:** Перейдіть до пайплайну `django-app-pipeline`.
3.  **Перегляньте останню збірку:** Ви побачите статус останньої збірки (успішно, помилка тощо). Натисніть на неї, щоб переглянути детальні логи.

### Як побачити результат в Argo CD

Argo CD відстежує зміни у вашому репозиторії та автоматично розгортає оновлення в Kubernetes.

1.  **Відкрийте Argo CD:** Знайдіть URL-адресу та пароль у вихідних даних Terraform (`terraform output`).
2.  **Знайдіть додаток:** Знайдіть додаток `django-chart`.
3.  **Перевірте статус:** Переконайтеся, що статус додатка `Healthy` та `Synced`. Це означає, що остання версія вашого додатка успішно розгорнута.
4.  **Перегляньте ресурси:** Натисніть на додаток, щоб побачити всі розгорнуті ресурси Kubernetes (Deployment, Service, Pods) та їхній поточний стан.
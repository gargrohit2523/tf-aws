resource "aws_db_instance" "bn-mysql-dev" {
  identifier_prefix   = "bn-dev-mysql"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  db_name                = "example_database"
  username            = "admin"

  skip_final_snapshot = true
  apply_immediately = true

  password            = jsondecode(
    data.aws_secretsmanager_secret_version.current.secret_string
  ).mysql-password
}

data "aws_secretsmanager_secret" "secrets" {
  name = "dev/bn/database/mysql"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

# locals {
#   db_password = jsondecode(
#     data.aws_secretsmanager_secret_version.current.secret_string
#   )
# }

terraform {
    backend "s3" {
      bucket = "bn-dev-tf-state"

      region = "us-east-1"
      key = "bn/dev/database/mysql/terraform.tfstate"

      encrypt = true
    }
}
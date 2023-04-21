output "mysql-domain" {
  value = aws_db_instance.bn-mysql-dev.domain
  description = "mysql domain"
}

output "mysql-endpoint" {
  value = aws_db_instance.bn-mysql-dev.endpoint
  description = "mysql endpoint"
}
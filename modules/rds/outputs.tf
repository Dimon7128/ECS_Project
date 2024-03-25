output "db_instance_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.default.id
}

output "db_connection_url" {
  value = "mysql://${aws_db_instance.default.endpoint}"
}

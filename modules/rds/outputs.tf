output "db_instance_endpoint" {
  value = split(":", aws_db_instance.default.endpoint)[0]
}


output "db_instance_id" {
  value = aws_db_instance.default.id
}

output "db_connection_url" {
  value = "mysql://${var.db_username}:${var.db_password}@${aws_db_instance.default.endpoint}/${var.db_name}"
}

output "rds_sg" {
    value =  [aws_security_group.db_sg.id]
}
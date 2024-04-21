output "ecs_tasks_role_arn" {
  description = "The ARN of the IAM role for ECS tasks."
  value       = aws_iam_role.ecs_tasks_role.arn
}

output "lambda_function_arn_rds" {
  description = "The ARN of the IAM role for RDS to S3 for the SQL init query"
  value = aws_iam_role.lambda_rds.arn
}

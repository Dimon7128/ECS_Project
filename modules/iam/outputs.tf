output "ecs_tasks_role_arn" {
  description = "The ARN of the IAM role for ECS tasks."
  value       = aws_iam_role.ecs_tasks_role.arn
}

output "lambda_exec_role_arn" {
  description = "The ARN of the IAM role for Lambda execution."
  value       = aws_iam_role.lambda_exec_role.arn
}

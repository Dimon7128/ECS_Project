output "ecs_tasks_role_arn" {
  description = "The ARN of the IAM role for ECS tasks."
  value       = aws_iam_role.ecs_tasks_role.arn
}

output "lambda_rds" {
  description = "The ARN of the IAM role for rds lambda func."
  value       = aws_iam_role.lambda_rds.arn
}

output "lambda_route53" {
  description = "The ARN of the IAM role for route53 func."
  value       = aws_iam_role.lambda_route53.arn
}
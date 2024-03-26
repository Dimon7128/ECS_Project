output "ecs_tasks_role_arn" {
  description = "The ARN of the IAM role for ECS tasks."
  value       = aws_iam_role.ecs_tasks_role.arn
}

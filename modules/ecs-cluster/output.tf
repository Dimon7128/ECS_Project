output "ecs_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

# output "nginx_task_definition_arn" {
#   value = aws_ecs_task_definition.nginx.arn
# }

# output "backend_task_definition_arn" {
#   value = aws_ecs_task_definition.backend.arn
# }

# output "nginx_service_name" {
#   value = aws_ecs_service.nginx.name
# }

# output "backend_service_name" {
#   value = aws_ecs_service.backend.name
#}
output "sg_of_task" {
    value = aws_security_group.ecs_tasks_sg.id
}

output "ecs_service_id" {
  value = aws_ecs_service.my_app.id
}
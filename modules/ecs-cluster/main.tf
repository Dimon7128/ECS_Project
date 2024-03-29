resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  # Allow inbound HTTP from the ALB to NGINX
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg]
  }

  # Allow internal communication on port 12345
  ingress {
    from_port   = 12345
    to_port     = 12345
    protocol    = "tcp"
    self        = true
  }

  # Outbound rules allowing access to RDS and internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = var.nginx_image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "backend-service"
      image     = var.backend_image
      cpu       = 256
      memory    = 512
      essential = true
      environment = [
        {
          name  = "DATABASE_URL"
          value = var.database_url
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    assign_public_ip = false
    security_groups = [aws_security_group.ecs_tasks_sg.id]
  }

  load_balancer {
    target_group_arn = var.nginx_target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    assign_public_ip = false
    security_groups = [aws_security_group.ecs_tasks_sg.id]
  }
}




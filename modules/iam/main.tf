resource "aws_iam_role" "ecs_tasks_role" {
  name = "ecs-tasks-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_role_policy" "ecs_tasks_policy" {
  name = "ecs-tasks-policy-${var.environment}"
  role = aws_iam_role.ecs_tasks_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          // Existing ECR permissions
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",

          // Existing CloudWatch Logs permissions
          "logs:CreateLogStream",
          "logs:PutLogEvents",

          // RDS permissions
          "rds-db:connect", // if using RDS IAM authentication
          "rds:*", // or specific RDS actions as needed

          // ECS permissions if needed
          "ecs:Describe*",
          "ecs:List*",

          // Add other permissions as needed
        ],
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole",
      },
    ],
  })

  tags = {
    Environment = var.environment
  }
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_exec_policy" {
  name = "lambda-exec-policy-${var.environment}"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          // Add permissions that Lambda needs for RDS access
          "rds-db:connect",
          "rds:*",
          // Permissions for VPC access
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          // Add other permissions as necessary
        ],
        Resource = "*",
      },
    ],
  })
}

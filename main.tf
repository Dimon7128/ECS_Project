terraform {
  backend "s3" {
    bucket         = "terrafomstatefile"
    key            = "terraform.tfstate"
    region         = var.region
    #dynamodb_table = "my-terraform-state-lock"
    encrypt        = true
  }
}


provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source         = "./modules/vpc"
  cidr_block           = var.cidr_block
  cidr_block_private_A = var.cidr_block_private_A
  cidr_block_public_A  = var.cidr_block_public_A
  cidr_block_private_B = var.cidr_block_private_B
  cidr_block_public_B  = var.cidr_block_public_B
  AZ_A                 = var.AZ_A
  AZ_B                 = var.AZ_B
}


module "alb" {
  source = "./modules/alb"
  alb_name              = var.alb_name
  vpc_id                = module.vpc.vpc_id
  public_subnets        = module.vpc.public_subnets
  tg_name               = var.tg_name
  tags_alb              = var.tags_alb
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
  timeout               = var.timeout
  health_check_path     = var.health_check_path // the path inside the app
  health_check_interval = var.health_check_interval
  domain_name           = var.domain_name
  zone_id               = var.zone_id
}
module "iam" {
  source      = "./modules/iam"
  environment = "production" # Or any other environment name
}


module "rds" {
  source               = "./modules/rds"
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_identifier        = var.db_identifier
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  parameter_group_name = var.parameter_group_name
  subnet_ids           = module.vpc.private_subnets
  vpc_id               = module.vpc.vpc_id
  db_port              = var.db_port
  cidr_blocks          = [var.cidr_block_private_A, var.cidr_block_private_B]     
  multi_az             = var.multi_az
  tags_rds             = var.tags_rds
}

module "ecs_cluster" {

  source                 = "./modules/ecs-cluster"
  cluster_name           = var.cluster_name
  nginx_image            = var.nginx_image
  backend_image          = var.backend_image
  execution_role_arn     = module.iam.ecs_tasks_role_arn
  subnets                = module.vpc.private_subnets
  vpc_id                 = module.vpc.vpc_id
  alb_sg                 = module.alb.alb_sg
  nginx_target_group_arn = module.alb.target_group_arn
  aws_region             = var.aws_region
  rds_host               = module.rds.db_instance_endpoint
  rds_db_name            = var.db_name    
  rds_password           = var.db_password  
  rds_username           = var.db_username
}


resource "aws_lambda_function" "rds_query_lambda" {
  function_name = "rds-query-function"
  handler       = "create_table_func.lambda_handler" # name of the function in the s3 bucket (inside .zip)
  s3_bucket     = var.s3_bucket
  s3_key        = "lambda_function.zip"
  runtime       = "python3.8" # Or any supported runtime version

  role          = module.iam.lambda_function_arn_rds

  environment {
    variables = {
      RDS_HOST    = module.rds.db_instance_endpoint
      DB_USERNAME = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = var.db_name
    }
  }

  vpc_config {
    // Assuming your Lambda needs to be in both subnets for high availability
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = module.rds.rds_sg
  }

  // Increase memory and timeout if necessary
  memory_size = 256 # in MB
  timeout     = 30  # in seconds
}


resource "null_resource" "invoke_lambda_after_creation" {
  # Depends on both the ECS service and Lambda functions being created
  depends_on = [
    module.ecs_cluster,
    module.rds,
    # Add any other Lambda functions here
  ]
    triggers = {
    ecs_service_id = module.ecs_cluster.ecs_service_id
    # lambda_rds_arn = module.rds
  }

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = <<-EOT
      aws lambda invoke --function-name ${aws_lambda_function.rds_query_lambda.arn} --payload '{"key": "value"}' response_rds.json
    EOT
  }
}
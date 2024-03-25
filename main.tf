terraform {
  backend "s3" {
    bucket         = "terrafomstatefile"
    key            = "terraform.tfstate"
    region         = "eu-west-3"
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



//module "ecs_cluster" {
  //source       = "./modules/ecs-cluster"
  //cluster_name = var.cluster_name
  //vpc_id       = module.vpc.vpc_id
  //subnets      = module.vpc.private_subnets
//}


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
  source            = "./modules/ecs-cluster"
  cluster_name      = var.cluster_name
  nginx_image       = var.nginx_image
  backend_image     = var.backend_image
  execution_role_arn= var.execution_role_arn
  database_url      = module.rds.db_connection_url
  subnets           = module.vpc.private_subnets
  vpc_id            = module.vpc.vpc_id
  alb_sg            = module.alb.alb_sg
  security_group_id = var.security_group_id           
  nginx_target_group_arn = var.nginx_target_group_arn
}

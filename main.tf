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
  tags                  = var.tags
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
  timeout               = var.timeout
  health_check_path     = var.health_check_path // the path inside the app
  health_check_interval = var.health_check_interval
}



# RDS Configuration
allocated_storage    = 20
engine               = "mysql"
engine_version       = "8.0.35"
instance_class       = "db.t3.micro"
db_identifier        = "mydbinstance"
db_name              = "mydatabase"
db_username          = "adminuser"
db_password          = "supersecretpassword"
parameter_group_name = "default.mysql8.0"
db_port              = 3306
multi_az             = true
tags_rds             = {
  Environment = "dev",
  Project     = "MyProject"
}

# ECS Cluster Configuration
cluster_name = "my-cluster"
nginx_image  = "your_image/nginx:tag"
backend_image = "your_image/backend:tag"

# AWS Route 53 Configuration
domain_name = "your.domain"
zone_id     = "your_hosted_zone_id"

# AWS Region
aws_region = "your-region"

# S3 Configuration for Lambda
s3_bucket = "name_of_bucket"

# VPC and Networking
cidr_block           = "10.1.0.0/16"
cidr_block_private_A = "10.1.1.0/24"
cidr_block_public_A  = "10.1.2.0/24"
cidr_block_private_B = "10.1.3.0/24"
cidr_block_public_B  = "10.1.4.0/24"
AZ_A                 = "your_region-a"
AZ_B                 = "your_region-b"

# Load Balancer Configuration
alb_name             = "my-alb-name"
tg_name              = "my_tg"
healthy_threshold    = 3
unhealthy_threshold  = 3
timeout              = 5
health_check_path    = "/"
health_check_interval= 30

variable "aws_region" {
  description = "AWS region"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
}


variable "cidr_block_private_A" {
  description = "CIDR block for the first private subnet."
}

variable "cidr_block_public_A" {
  description = "CIDR block for the first public subnet."
}

variable "cidr_block_private_B" {
  description = "CIDR block for the second private subnet."
}

variable "cidr_block_public_B" {
  description = "CIDR block for the second public subnet."
}

variable "AZ_A" {
  description = "Availability Zone A."
}

variable "AZ_B" {
  description = "Availability Zone B."
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}



variable "tg_name" {
  description = "The name of the target group"
  type        = string
}

variable "tags_alb" {
  description = "A map of tags to assign to the ALB and target group"
  type        = map(string)
  default     = {}
}
variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = number 
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a healthy target unhealthy."
  type        = number
}

variable "timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check."
  type        = number
}

variable "health_check_path" {
  description = "The destination for the health check request, which is the path inside the app."
  type        = string
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target."
  type        = number
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes for the RDS instance."
}

variable "engine" {
  description = "The database engine to use."
}

variable "engine_version" {
  description = "The engine version to use."
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
}

variable "db_identifier" {
  description = "The identifier for the RDS instance."
}

variable "db_name" {
  description = "The name for the RDS database."
}

variable "db_username" {
  description = "Username for the RDS database."
}

variable "db_password" {
  description = "Password for the RDS database."
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this RDS instance."
}


variable "db_port" {
  description = "The port on which the database accepts connections."
}


variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = false
}

variable "tags_rds" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "Name of the ECS cluster where services will be deployed."
  type        = string
}

variable "nginx_image" {
  description = "Docker image to use for the NGINX service in the ECS cluster."
  type        = string
}

variable "backend_image" {
  description = "Docker image to use for the backend application service in the ECS cluster."
  type        = string
}

variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "zone_id" {
  description = "Existing hosted zone"
  type        = string
}

variable "s3_bucket" {
  description = "s3 bucket where the zip file is placed."
  type        = string
}
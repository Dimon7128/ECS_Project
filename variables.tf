variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-3"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}


variable "cidr_block_private_A" {
  description = "CIDR block for the first private subnet."
  default     = "10.1.1.0/24"
}

variable "cidr_block_public_A" {
  description = "CIDR block for the first public subnet."
  default     = "10.1.2.0/24"
}

variable "cidr_block_private_B" {
  description = "CIDR block for the second private subnet."
  default     = "10.1.3.0/24"
}

variable "cidr_block_public_B" {
  description = "CIDR block for the second public subnet."
  default     = "10.1.4.0/24"
}

variable "AZ_A" {
  description = "Availability Zone A."
  default     = "eu-west-3a"
}

variable "AZ_B" {
  description = "Availability Zone B."
  default     = "eu-west-3b"
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default = "my-alb-name"
}



variable "tg_name" {
  description = "The name of the target group"
  type        = string
  default = "my_tg"

}

variable "tags_alb" {
  description = "A map of tags to assign to the ALB and target group"
  type        = map(string)
  default     = {}
}
variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a healthy target unhealthy."
  type        = number
  default     = 3
}

variable "timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check."
  type        = number
  default     = 5
}

variable "health_check_path" {
  description = "The destination for the health check request, which is the path inside the app."
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target."
  type        = number
  default     = 30
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

variable "s3_bucket" {
  description = "The name of the S3 bucket containing the Lambda function code."
  type        = string
}

variable "s3_key_rds" {
  description = "The S3 key of the Lambda function's deployment package for func that creates the table in the rds."
  type        = string
}

variable "s3_key_route53" {
  description = "The S3 key of the Lambda function's deployment package for the func that creates record in route 53."
  type        = string
}

variable "route53_zone_id" {
  description = "Zone ID of the route53 - the question is how i should to retrive it from aws, or better create it from zero...?"
  type        = string
}

variable "domain_name" {
  description = "domain name"
  type        = string
}
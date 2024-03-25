variable "cluster_name" {
  description = "The name of the ECS cluster where services will be deployed."
  type        = string
}

variable "nginx_image" {
  description = "The Docker image for the NGINX container."
  type        = string
}

variable "backend_image" {
  description = "The Docker image for the backend application container."
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that the ECS tasks will assume for permissions to AWS services."
  type        = string
}

variable "database_url" {
  description = "The URL for the database that the backend application will connect to."
  type        = string
}

variable "subnets" {
  description = "The list of subnet IDs for the ECS tasks to be deployed within."
  type        = list(string)
}

variable "nginx_target_group_arn" {
  description = "The ARN of the target group for the NGINX service."
  type        = string
}
variable "vpc_id" {
    description = "The id of the vpc"
    type = string
  
}
variable "alb_sg" {
  description = "The ID of the sg of the alb"
  type = string
}
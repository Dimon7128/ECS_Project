variable "alb_name" {
  description = "The name of the Application Load Balancer (ALB)."
  type        = string
}


variable "public_subnets" {
  description = "List of public subnet IDs where the ALB will be deployed."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB and its resources will be created."
  type        = string
}

variable "tg_name" {
  description = "The name of the target group associated with the ALB."
  type        = string
}

variable "tags_alb" {
  description = "A map of tags to assign to the ALB and target group resources."
  type        = map(string)
}

variable "healthy_threshold" {
  description = "The number of consecutive health check successes required before considering an unhealthy target healthy."
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
  description = "The destination for the health check request."
  type        = string
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target."
  type        = number
}


variable "zone_id" {
  description = "zone id of the route53."
  type        = string
}
variable "domain_name" {
  description = "the domain name that will be the endpoint to the static app."
  type        = string
}
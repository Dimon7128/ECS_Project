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
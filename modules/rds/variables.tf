
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

variable "role_lambda" {
  description = "The role to lambda function that aloows to run query in the rds"
  type = string
  
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

variable "subnet_ids" {
  description = "A list of VPC subnet IDs to create the RDS instance in."
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID."
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
variable "cidr_blocks" {
    description = "cidr block that can access to rds"
    type = list(string)
}
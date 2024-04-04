variable "s3_bucket" {
  description = "The name of the S3 bucket containing the Lambda function code."
  type        = string
}

variable "s3_key" {
  description = "The S3 key of the Lambda function's deployment package."
  type        = string
}

variable "lambda_role_arn" {
  description = "The ARN of the IAM role that Lambda will assume."
  type        = string
}

variable "rds_host" {
  description = "Hostname for the RDS instance."
  type        = string
}

variable "db_username" {
  description = "Username for the database."
  type        = string
}

variable "db_password" {
  description = "Password for the database."
  type        = string
}

variable "db_name" {
  description = "Name of the database."
  type        = string
}

variable "subnets" {
  description = "Private subnets where is rds configured"
  type        = list(string)
}

variable "rds_sg" {
  description = "The sg of the rds"
  type        =  list(string)
}
 

resource "aws_lambda_function" "rds_query_lambda" {
  function_name = "rds-query-function"
  handler       = "create_table_func.lambda_handler" # name of the function in the s3 bucket (inside .zip)
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  runtime       = "python3.8" # Or any supported runtime version

  role          = var.lambda_role_arn

  environment {
    variables = {
      RDS_HOST    = var.rds_host
      DB_USERNAME = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = var.db_name
    }
  }

  vpc_config {
    // Assuming your Lambda needs to be in both subnets for high availability
    subnet_ids         = var.subnets
    security_group_ids = var.rds_sg 
  }

  // Increase memory and timeout if necessary
  memory_size = 256 # in MB
  timeout     = 30  # in seconds
}


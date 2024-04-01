resource "aws_lambda_function" "rds_query_lambda" {
  function_name = "rds-query-function"
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  handler       = "lambda_function.lambda_handler" # Adjust based on your Python file and handler function
  runtime       = "python3.8" # Or any supported runtime version

  role          = var.lambda_role_arn

  environment {
    variables = {
      RDS_HOST     = var.rds_host
      DB_USERNAME = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = var.db_name
    }
  }
}

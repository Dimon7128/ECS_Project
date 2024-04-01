output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.rds_query_lambda.arn
}

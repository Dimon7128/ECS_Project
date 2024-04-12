output "lambda_function_arn_rds" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.rds_query_lambda.arn
}

output "lambda_function_name_rds" {
  value = aws_lambda_function.rds_query_lambda.function_name
}

output "lambda_function_arn_route53" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.record_creator.arn
}

output "lambda_function_name_route53" {
  value = aws_lambda_function.record_creator.function_name
}


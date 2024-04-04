resource "aws_lambda_function" "hello_lambda" {
  function_name = "HelloLambdaFunction"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  s3_bucket     = "lambda-functions12"
  s3_key        = "table-rds/lambda_function.zip"
  role          = aws_iam_role.lambda_exec_role.arn
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

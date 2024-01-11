resource "aws_lambda_function" "ama-backend" {
  filename      = "main.zip"
  function_name = "ama-backend"
  role          = aws_iam_role.lambda_role.arn
  handler       = "placeholder"
  runtime       = "nodejs18.x"
  environment {
  }
  timeout = "30"
  lifecycle {
    ignore_changes = [
      last_modified,
      handler,
      runtime,
      environment,
      qualified_arn,
      source_code_hash,
      version,
      description,
      memory_size,
      timeout
    ]
  }
}

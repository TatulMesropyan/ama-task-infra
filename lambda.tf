resource "aws_lambda_function" "ama-backend" {
  filename      = "./build/main.zip"
  function_name = "${local.resource_prefix}-backend"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "server.handler"
  runtime       = "nodejs16.x"
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

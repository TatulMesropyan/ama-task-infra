locals {
  resource_prefix = "ama"
}

### API Gateway

resource "aws_api_gateway_rest_api" "ama-backend" {
  name        = "${local.resource_prefix}-backend"
  description = "Backend API Gateway for AMA"
}

resource "aws_api_gateway_resource" "ama-backend-proxy" {
  rest_api_id = aws_api_gateway_rest_api.ama-backend.id
  parent_id   = aws_api_gateway_rest_api.ama-backend.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "ama-backend-method" {
  rest_api_id   = aws_api_gateway_rest_api.ama-backend.id
  resource_id   = aws_api_gateway_resource.ama-backend-proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  depends_on = [aws_api_gateway_resource.ama-backend-proxy]
}

resource "aws_api_gateway_integration" "ama-backend-integration" {
  rest_api_id             = aws_api_gateway_rest_api.ama-backend.id
  resource_id             = aws_api_gateway_resource.ama-backend-proxy.id
  http_method             = aws_api_gateway_method.ama-backend-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.ama-backend.invoke_arn

  depends_on = [aws_api_gateway_method.ama-backend-method]
}

resource "aws_api_gateway_deployment" "ama-backend-deployment" {
  rest_api_id = aws_api_gateway_rest_api.ama-backend.id
  stage_name  = "default"
}


### Lambda
resource "aws_lambda_function" "ama-backend" {
  filename      = "./build/main.zip"
  function_name = "${local.resource_prefix}-backend"
  role          = aws_iam_role.lambda_execution_role.arn
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

resource "aws_lambda_permission" "ama-backend-apigateway_invoke" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ama-backend.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.ama-backend.execution_arn}/*/*"
}

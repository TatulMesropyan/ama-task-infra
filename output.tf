output "apigateway_invoke_url" {
  value = aws_api_gateway_deployment.ama-backend-deployment.invoke_url
}

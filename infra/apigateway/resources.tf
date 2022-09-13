resource "aws_apigatewayv2_api" "api" {
  name          = "api"
  protocol_type = "HTTP"
  target        = var.function_get_items_arn
}

resource "aws_lambda_permission" "api-lambda-permission" {
  action        = "lambda:InvokeFunction"
  function_name = var.function_get_items_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}

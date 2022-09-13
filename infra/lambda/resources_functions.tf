locals {
  memory_size   = 128
  timeout       = 5
  package_type  = "Zip"
  runtime       = "nodejs16.x"
  architectures = ["x86_64"]
}

resource "aws_lambda_alias" "get-items-dev" {
  function_name    = aws_lambda_function.get-items.function_name
  function_version = "$LATEST"
  name             = "latest"
}

data "archive_file" "get-items-archive" {
  source_file = "${path.root}/../app/nodejs/src/get_items.js"
  output_path = "${path.root}/../out/get_items.zip"
  type        = "zip"
}

resource "aws_lambda_function" "get-items" {
  function_name = "get-items"
  role          = aws_iam_role.lambda-role.arn
  handler       = "app/nodejs/src/get_items.handler"
  filename      = "${path.root}/../out/get_items.zip"
  package_type  = local.package_type
  memory_size   = local.memory_size
  timeout       = local.timeout
  architectures = local.architectures
  runtime       = local.runtime
  layers        = [aws_lambda_layer_version.common-libs-layer.arn]

  environment {
    variables = {
      REGION = var.region
      TABLE  = var.table_name
    }
  }
}

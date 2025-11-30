module "lambda_function" {
  source        = "../modules/lambda"
  function_name = "lambda_function"
  runtime       = "java21"
  region        = "us-east-1"
  handler       = "main"
  tags = {
    Name = "lambda_function"
  }
  filename = "lambda_function.zip"
}


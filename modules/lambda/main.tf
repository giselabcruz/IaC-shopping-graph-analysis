locals {
  role_name = "${var.function_name}_lambda_execution_role"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_execution_role.arn
  region        = var.region
  runtime       = var.runtime
  environment {
    variables = var.env_variables
  }
  tags = var.tags
}


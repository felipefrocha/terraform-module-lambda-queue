
resource "aws_sns_topic" "topic" {
  name         = var.s3_event_name
  display_name = "Cemed Request Notification"
  tags         = var.tags

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Principal = {
            Service = "lambda.amazonaws.com"
          }
          Action   = "SNS:Publish"
          Resource = "*"
          Condition = {
            ArnLike = {
              "aws:SourceArn" : "${aws_lambda_function.func.arn}"
            }
          }
        }
      ]
  })
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })

  inline_policy {
    name = "IncludeSNSPermission"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        # {
        #   Effect   = "Allow"
        #   Action   = "s3:*"
        #   Resource = "${aws_s3_bucket.data_lake.arn}/*"
        # },
        {
          Action = [
            "sns:Publish",
            "sns:Subscribe"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action = [
            "sqs:ReceiveMessage",
            "sqs:DeleteMessage",
            "sqs:GetQueueAttributes",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "ssm:GetParameter",
            "ec2:*"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action = [
            "kms:GenerateDataKey",
            "kms:Decrypt",
            "kms:Encrypt"
          ]
          Effect   = "Allow"
          Resource = "*"
        },

      ]
    })
  }
}

resource "aws_lambda_permission" "allow_queue" {
  statement_id  = "AllowExecutionFromAWS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "sqs.amazonaws.com"
  source_arn    = var.sqs_arn
}

resource "aws_lambda_event_source_mapping" "queue_invoke" {
  event_source_arn = var.sqs_arn
  function_name    = aws_lambda_function.func.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.source_executable_file_path
  output_path = var.lambda_function_zip_name
}

resource "aws_lambda_function" "func" {
  filename      = data.archive_file.lambda.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.lambda_function_handler
  runtime       = var.lambda_runtime
  timeout       = var.timeout
  publish = true
  reserved_concurrent_executions = 10
  architectures = [ "x86_64" ]
  layers = [
    var.lambda_nodejs_layer_arn
  ]

  source_code_hash = data.archive_file.lambda.output_base64sha256
  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
  memory_size = var.memory
  environment {
    variables = {
      DATABASE_PASSWD     = var.database_passwd
      DATABASE_USER       = var.database_user
      DATABASE_HOST       = var.database_host
      DATABASE_DB         = var.database_db
      DATABASE_PORT       = var.database_port
      DATABASE_ENABLE_SSL = var.database_enble_ssl
    }
  }
}

resource "aws_lambda_alias" "func" {
  name             = "createRequestController"
  description      = "Creates a Request and Split data to multiples entities"
  function_name    = aws_lambda_function.func.arn
  function_version = aws_lambda_function.func.version
  # routing_config {
  #   additional_version_weights = {
  #     "${aws_lambda_function.func.version}" = 0.01
  #   }
  # }
}
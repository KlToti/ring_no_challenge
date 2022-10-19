#data "aws_iam_role" "iam_for_lambda" {
#  name = "iam_for_lambda"
#}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_role_policy" {
  name        = "lambda-role"
  description = "policy for lambda's role"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Resource": "${data.aws_s3_bucket.my_bucket.arn}/*"
        },
        {
            "Effect": "Allow",
            "Action": ["ec2:DescribeInstances"],
            "Resource": "*"
        }
      ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_role_attach" {
  role       = data.aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_role_policy.arn
}

data "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name
}

data "archive_file" "lambda_deployment" {
  type        = "zip"
  source_file = "${path.module}/trigger.py"
  output_path = "${path.module}/files/trigger.zip"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.my_bucket.arn
}

resource "aws_lambda_function" "func" {
  filename         = data.archive_file.lambda_deployment.output_path
  function_name    = "trigger"
  role             = data.aws_iam_role.iam_for_lambda.arn
  handler          = "trigger.lambda_handler"
  source_code_hash = data.archive_file.lambda_deployment.output_base64sha256
  runtime          = "python3.9"
  timeout          = 60

  environment {
    variables = {
      donor_account_id   = var.donor_account_id
      forward_account_id = var.forward_account_id
      account_id         = var.account_id
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = data.aws_s3_bucket.my_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
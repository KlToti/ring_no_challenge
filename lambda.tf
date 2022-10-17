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
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "notification_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/files/trigger.zip"
  function_name = "send_notification"
  role          = aws_iam_role.iam_for_lambda.arn 
  #entry point of the lambda function, which function is going to be called first
  handler       = "trigger.lambda_handler" 

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "python3.9"

}

data "archive_file" "lambda_deployment" {
  type        = "zip"
  source_file = var.path_to_triggerLambda
  output_path = var.path_to_output
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"             # trigger
  function_name = aws_lambda_function.notification_lambda.arn       # lambda_funciton
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_name.arn                 # own bucket
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket_name.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.notification_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
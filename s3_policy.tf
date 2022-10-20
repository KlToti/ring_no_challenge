
resource "aws_s3_bucket_policy" "allow_access_to_s3_policy" {
  bucket = data.aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.allow_access_to_s3_document.json
}

data "aws_iam_policy_document" "allow_access_to_s3_document" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.donor_account_id]                            # allows donor_account_id to put files in s3
    }
    actions = [
      "s3:PutObject",
    ]
    resources = [
      data.aws_s3_bucket.my_bucket.arn,
      "${data.aws_s3_bucket.my_bucket.arn}/*",
    ]
  }

  statement {

    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [resource.aws_iam_role.iam_for_lambda.arn]        # allows lambda to do anything on s3
    }
    actions   = ["s3:*"]
    resources = ["${data.aws_s3_bucket.my_bucket.arn}/*"]
  }

    statement {

    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.iam_for_webserver.arn]                  # allows ec2 to copy files from s3
    }
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.my_bucket.arn}/*"]
  }
}
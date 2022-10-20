
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = data.aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.donor_account_id]
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
    sid    = "ExampleStmt"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [resource.aws_iam_role.iam_for_lambda.arn]
    }
    actions   = ["s3:*"]
    resources = ["${data.aws_s3_bucket.my_bucket.arn}/*"]
  }
}
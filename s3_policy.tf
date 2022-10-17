resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = var.bucket_name.id                                                                   
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
      var.bucket_name.arn,
      "${var.bucket_name.arn}/*",
    ]
  }
}
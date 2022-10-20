terraform {
    required_version = ">=1.2.9"
}

resource "aws_s3_bucket" "project_bucket" {
    bucket = var.s3_bucket_name

    lifecycle {
      prevent_destroy = true
    }

    tags = var.tags
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
  bucket = aws_s3_bucket.project_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
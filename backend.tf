terraform {
  backend "s3" {
    bucket = var.bucket_name
    key    = "ring_challenge/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}
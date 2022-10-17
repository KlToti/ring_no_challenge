terraform {
  backend "s3" {
    bucket         = "ta-terraform-tfstates-339774688473"
    key            = "projects/ta-ring-challenge/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}
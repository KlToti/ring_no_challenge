terraform {
  backend "s3" {
    s         = "ta-terraform-tfstates-686520628199"
    key            = "projects/ring_no_challange/Team3/lambda/terraform.tfstates"
    region = "eu-central-1"
    dynamodb_table = "terraform-lock"
    profile = "talent-academy"
  }
}
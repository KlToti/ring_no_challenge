terraform {
  backend "s3" {
    bucket         = "ta-terraform-tfstates-041308375526"
    key            = "project/ring_no_challange/Team3/ec2/terraform.tfstates"
    region = "eu-central-1"
    dynamodb_table = "terraform-lock"
    profile = "talent-academy"
  }
}
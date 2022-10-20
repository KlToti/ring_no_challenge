# ALL VARIABLES

variable "ubuntu_ami_owner_id" {
  description = "Contains the Owner ID of the ami for amazon linux"
  type        = string
}

variable "ubuntu_ami_name" {
  description = "Name of the ami I want for my project"
  type        = string
}

variable "membername" {
  description = "Name of Instance Owner"
  type = string
}

variable "projectname" {
  description = "Name of Project"
  type = string
}

variable "vpc_name" {
  description = "Name of our VPC"
  type = string
}

variable "public_subnet_name" {
  description = "Name of Public Subnet"
}

variable "s3_bucket_name" {
  description = "S3 Bucket for Backend terraform.tf.states"
  type = string
}

variable "keypair_name" {}


variable "s3_bucket_name" {
  description = "bucket name"
  type        = string
}

variable "donor_account_id" {
  description = "previous person's id"
  type        = string
}


variable "forward_account_id" {
  description = "following person's id"
  type        = string
}

variable "account_id" {
  description = "your id"
  type        = string
}

variable "forward_bucket_name" {
  description = "forward_bucket_name"
  type = string
}
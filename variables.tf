variable "s3_bucket_name" {
  description = "bucket name"
  type        = string
}

variable "donor_account_id" {
  description = "previous person's id"
  type        = number
}


variable "forward_account_id" {
  description = "following person's id"
  type        = number
}

variable "account_id" {
  description = "your id"
  type        = number
}
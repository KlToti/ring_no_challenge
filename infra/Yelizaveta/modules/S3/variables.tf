# DEFINING ALL VARIABLES

variable "s3_bucket_name" {
  description = "Contains the Name of the s3 Bucket"
  type        = string
  default = "project-bucket"
}

variable "tags" {
  description = "S3 Bucket tags"
  type = object({
    Name = string
    Project = string
  })
  default = {
    Name = "Project Bucket"
    Project = ""
  }
}
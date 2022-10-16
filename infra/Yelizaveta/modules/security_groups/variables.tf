# DEFINING ALL VARIABLES

variable "vpc_name" {
  description = "Name of the VPC instance"
  type        = string
}

variable "public_sg_name" {
  description = "Instance Name of public Security Group. Do not use blanks!"
  type = string
  default = "public-sg"
}

variable "private_sg_name" {
  description = "Instance Name of private Security Group. Do not use blanks!"
  type = string
  default = "private-sg"
}

variable "public_sg_tags" {
  description = "Tags of public Security Group for webserver"
  type = object ({
    Name = string
    Project = string
  })
  default = {
    Name = "public-sg"
    Project = ""
  }
}

variable "private_sg_tags" {
  description = "Tags of private Security Group for private Server"
  type = object ({
    Name = string
    Project = string
  })
  default = {
    Name = "private-sg"
    Project = ""
  }
}
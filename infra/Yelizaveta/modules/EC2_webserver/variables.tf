# DEFINING ALL VARIABLES

variable "ami" {
  description = "AMI Datasource ID"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 Instance for Webserver"
  type        = string
  default = "t2.micro"
}

variable "public_subnet_id" {
  description = "The Name of my Private Subnet"
  type        = string
}

variable "public_sg_id" {
  description = "Instance ID of public Security Group"
  type = string
}

variable "keypair_name" {}

variable "tags" {
  description = "Tags of public Security Group for private Server"
  type = object ({
    Name = string
    Project = string
  })
  default = {
    Name = "private server"
    Project = ""
  }
}
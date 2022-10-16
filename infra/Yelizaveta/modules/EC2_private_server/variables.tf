# DEFINING ALL VARIABLES

variable "ami" {
  description = "AMI Datasource ID"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 Instance for private Server"
  type        = string
  default = "t2.micro"
}

variable "private_subnet_id" {
  description = "The Name of my private Subnet"
  type        = string
}

variable "private_sg_id" {
  description = "Instance ID of private Security Group"
  type = string
}

variable "keypair_name" {}

variable "tags" {
  description = "Tags of private Security Group for private Server"
  type = object ({
    Name = string
    Project = string
  })
  default = {
    Name = "private server"
    Project = ""
  }
}
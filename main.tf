#VPC of Talent_Academy Lab account
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.ring_vpc]
  }
}

#Public Subnet
data "aws_subnet" "public_1" {
  filter {
    name   = "tag:Name"
    values = [var.ring_public_sb]
  }
}

#Private Subnet
data "aws_subnet" "private_1" {
  filter {
    name   = "tag:Name"
    values = [var.ring_private_sb]
  }
}
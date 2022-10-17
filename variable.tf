# DEFINING ALL VARIABLES
variable "ring_vpc" {
  description = "The name of the VPC"
  type        = string
}

variable "ring_public_sb" {
  description = "The name of my public subnet 1"
  type        = string
}

variable "ring_private_sb" {
  description = "The name of my private subnet 1"
  type        = string
}

variable "my_keypair" {}
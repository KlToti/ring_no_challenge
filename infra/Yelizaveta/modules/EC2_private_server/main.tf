terraform {
    required_version = ">=1.3.2"
}

resource "aws_instance" "private_server" {
  ami                       = var.ami
  instance_type             = var.instance_type
  subnet_id                 = var.private_subnet_id
  vpc_security_group_ids    = [var.private_sg_id]
  key_name                  = var.keypair_name

  tags = var.tags
}
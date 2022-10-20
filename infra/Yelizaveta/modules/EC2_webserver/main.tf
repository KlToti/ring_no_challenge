terraform {
    required_version = ">=1.2.9"
}

resource "aws_instance" "webserver" {
  ami                       = var.ami
  instance_type             = var.instance_type
  subnet_id                 = var.public_subnet_id
  vpc_security_group_ids   = [var.public_sg_id]
  key_name                  = var.keypair_name

  tags = var.tags
}
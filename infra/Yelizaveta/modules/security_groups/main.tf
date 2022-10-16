terraform {
    required_version = ">=1.3.2"
}

resource "aws_security_group" "public_sg" {
  name        = var.public_sg_name
  description = "SG for webserver"
  vpc_id      = var.vpc_name

  # INBOUND CONNECTIONS
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # INBOUND CONNECTIONS
  ingress {
    description = "Access to webapp"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # OUTBOUT CONNECTIONS
  egress {
    description = "Access to the internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP PROTOCOL
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.public_sg_tags
}

resource "aws_security_group" "private_sg" {
  name        = var.private_sg_name
  description = "SG for private server"
  vpc_id      = var.vpc_name

  # INBOUND CONNECTIONS
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  # INBOUND CONNECTIONS
  ingress {
    description = "Access to webapp"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # OUTBOUT CONNECTIONS
  egress {
    description = "Access to the internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP PROTOCOL
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = var.private_sg_tags
}
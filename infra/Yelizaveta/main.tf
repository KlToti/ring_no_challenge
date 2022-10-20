data "aws_ami" "ubuntu_image" {
  owners      = [var.ubuntu_ami_owner_id]
  most_recent = true # latest
  filter {
    name   = "name"
    values = [var.ubuntu_ami_name]
  }
}

data "aws_vpc" "vpc" {

  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_subnet" {

  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }
}

module "s3_project_bucket" {
  source = "./modules/S3"
  s3_bucket_name = var.s3_bucket_name
  tags = {
    Name = "${var.projectname}_s3_bucket"
    Project = var.projectname
  }
}

module "sg" {
  source = "./modules/security_groups"
  vpc_name = data.aws_vpc.vpc.id
  public_sg_tags = {
    Name = "${var.projectname}_public_sg"
    Project = var.projectname
  }
}

module "webserver" {
  source = "./modules/EC2_webserver"
  ami = data.aws_ami.ubuntu_image.id
  public_subnet_id = data.aws_subnet.public_subnet.id
  public_sg_id = module.sg.public_sg_id
  keypair_name = var.keypair_name
  tags = {
    Name = "${var.projectname}_webserver"
    Project = var.projectname
  }
}

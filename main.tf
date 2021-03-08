# Provider
provider "aws" {
  region = var.aws_region
}

# Latest Ubuntu 16.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
    "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
    "hvm"]
  }

  owners = [
  "099720109477"]
  # Canonical
}


# List of Subnets to attach to LC/ASG
data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id

  tags = {
    Zone = var.subnet_type
  }
}

resource "aws_launch_configuration" "lc" {
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_role
  key_name             = var.key_name
  security_groups      = var.security_groups_ids
}
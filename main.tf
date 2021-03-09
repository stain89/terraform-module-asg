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

# Launch Configuration
resource "aws_launch_configuration" "lc" {
  name                 = "${var.name}-lc"
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_role
  key_name             = var.key_name
  security_groups      = var.security_groups_ids
  user_data            = var.user_data

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      no_device             = lookup(ebs_block_device.value, "no_device", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
    }
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      ami,
    user_data]
  }
}

#Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  max_size             = var.max_size
  min_size             = var.min_size
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier = [
  data.aws_subnet_ids.subnets.ids]
  load_balancers = [
  var.load_balancers]
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = "${var.name}-asg-ec2"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.environment
      propagate_at_launch = true
    }
  ]

}
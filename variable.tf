variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where Security Group will be provisioned"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID in which Security Group will be provisioned"
}

variable "name" {
  type        = string
  default     = "test"
  description = "Name of product to which resource belongs to"
}

variable "environment" {
  type        = string
  default     = "test"
  description = "Environment resource belong to. Ex Dev/Test/Prod"
}

variable "subnet_type" {
  type        = string
  default     = "Private"
  description = "Subnet type. Either Private or Public."
}

variable "instance_type" {
  default     = "t2.small"
  description = "The size of instance to launch"
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = ""
}

variable "iam_role" {
  type        = string
  default     = ""
  description = "IAM role that should be used for the instances"
}

variable "security_groups_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the ELB"
}

variable "user_data" {
  default     = ""
  type        = string
  description = "Custom user data or configuration script that needs to be run at boot"
}

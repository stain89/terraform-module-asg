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
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(map(string))
  default     = []
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "min_size" {
  description = "Min number of instances in ASG"
  default     = 1
  type        = number
}

variable "max_size" {
  description = "Max number of instances in ASG"
  default     = 1
  type        = number
}

variable "load_balancers" {
  description = "A list of elastic load balancer names to add to the autoscaling group names"
  type        = list(string)
  default     = []
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = 300
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
  type        = string
  default     = "ELB"
}
variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
  type        = bool
  default     = false
}
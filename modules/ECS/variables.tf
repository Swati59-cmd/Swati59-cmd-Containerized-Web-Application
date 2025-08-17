variable "environment" {}
variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "ecr_repo_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "ecs_sg_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "desired_capacity" { default = 2 }
variable "max_size" { default = 3 }
variable "min_size" { default = 1 }
variable "service_desired_count" { default = 2 }
variable "target_group_arn" {}
variable "alb_listener_arn" {}


variable "environment" {
  description = "Environment name"
  type        = string

}
variable "instance_type" {
  description = "EC2 instance type for ECS cluster"
  type        = string

}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string

}

variable "ecr_repo_name" {
  type = string

}
variable "aws_account_id" {
  type = number

}
variable "aws_region" {
  type = string

}

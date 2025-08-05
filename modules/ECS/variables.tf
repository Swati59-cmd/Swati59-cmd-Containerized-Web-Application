variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "ami_id" {
  description = "AMI ID for ECS EC2 instances"
  type        = string
  default     = "ami-0953476d60561c955"
}

variable "instance_type" {
  description = "EC2 instance type for ECS cluster"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "lambda"
}
variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
  default     = "devpython"
}
variable "aws_account_id" {
  type    = number
  default = 851725602228
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
  default     = "arn:aws:acm:us-east-1:851725602228:certificate/cb556548-3b63-4ca3-b5ae-9f6a1ab4dbdd"
}





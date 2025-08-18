variable "environment" {
  description = "Environment name"
  type        = string

}

variable "ami_id" {
  description = "AMI ID for ECS EC2 instances"
  type        = string
  default     = "ami-0953476d60561c955"
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
variable "aws_region" {
  type    = string
  default = "us-east-1" # adjust to your actual region
}
variable "aws_account_id" {
  type = string
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}
variable "acm_certificate_arn" {
  type = string
}
variable "alb_domain" {
  type = string
}






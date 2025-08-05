variable "environment" {
  description = "Environment name"
  type        = string
  default     = "main"
}

variable "ami_id" {
  description = "AMI ID for ECS EC2 instances"
  type        = string
  default     = "ami-0953476d60561c955"
}


variable "image" {
  description = "Docker image to be used in ECS task"
  type        = string
  default     = "648908580279.dkr.ecr.us-east-1.amazonaws.com/devpython"
}

variable "alb_target_group_arn" {
  description = "ARN of the ALB Target Group"
  type        = string
  default     = "aws_lb_target_group.tg.arn"
}

variable "alb_listener_arn" {
  description = "ARN of the ALB Listener"
  type        = string
  default     = " aws_lb_listener.listener.arn"
}
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "instance_type" {
  description = "Bastion instance type"
  type        = string
  default     = "t2.micro"
}
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "lambda"
}

variable "ami" {
  type    = string
  default = "ami-0cbbe2c6a1bb2ad63"
}

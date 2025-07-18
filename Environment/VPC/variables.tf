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

variable "instance_type" {
  description = "EC2 instance type for ECS cluster"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "lambda"
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

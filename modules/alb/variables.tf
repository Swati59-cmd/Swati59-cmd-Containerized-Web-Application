variable "environment" {
  description = "Environment name"
  type        = string

}

variable "ami_id" {
  description = "AMI ID for ECS EC2 instances"
  type        = string

}



variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string

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
variable "public_subnet_ids" {
  type = list(string)
}

variable "ecs_alb_sg" {
  type = string
}

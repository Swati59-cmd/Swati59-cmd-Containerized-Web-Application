variable "environment" {
  description = "Environment name[main/stage]"
  type        = string
  default     = "stage"
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
  default     = "648908580279.dkr.ecr.us-east-1.amazonaws.com/stagepython"
}
variable "subnet_ids" {
  description = "List of Public subnet for ALB"
  type        = list(string)
  default     = ["subnet-0989adfb31834e9c0", "subnet-0ff6fb1a2203b472d"]
}
variable "private_subnet_ids" {
  description = "List of Private subnet for EC2"
  type        = list(string)
  default     = ["subnet-0b9b38966e22694b2", "subnet-00956bf065fff8108"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-0c36c5cc9375eb9b1"

}

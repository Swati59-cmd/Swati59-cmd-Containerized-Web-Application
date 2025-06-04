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
  default     = ["subnet-052312b45c84846d5", "subnet-06830bd1c3c6d96c5"]
}
variable "private_subnet_ids" {
  description = "List of Private subnet for EC2"
  type        = list(string)
  default     = ["subnet-00404b7f5b0b89228", "subnet-00956bf065fff8108"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-08c1c2b16edf355b6"

}

variable "environment" {
  description = "Environment name[main/stage]"
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
  default     = "648908580279.dkr.ecr.us-east-1.amazonaws.com/mainpython"
}
variable "subnet_ids" {
  description = "List of Public subnet for ALB"
  type        = list(string)
  default     = ["subnet-0aba4b0328da6320a", "subnet-0aae5b39fa10edc20"]
}
variable "private_subnet_ids" {
  description = "List of Private subnet for EC2"
  type        = list(string)
  default     = ["subnet-0827312ce30eea1cb", "subnet-023797ce49f14ec79"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-08548ac86f9ac37a0"
}

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
  default     = ["subnet-0ddd74038a5230ac1", "subnet-078fbd5b2948d20b6"]
}
variable "private_subnet_ids" {
  description = "List of Private subnet for EC2"
  type        = list(string)
  default     = ["subnet-0ef21a3c4fb08f210", "subnet-00fb3a01f5fb27712"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-04246a220f62f3988"

}

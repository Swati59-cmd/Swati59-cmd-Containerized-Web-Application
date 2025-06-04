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
variable "subnet_ids" {
  description = "List of subnet IDs for ALB"
  type        = list(string)
  default     = ["subnet-04806bcee66531c9a", "subnet-069b77f30d435ad66"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-05550d62bcf2d063e"
}




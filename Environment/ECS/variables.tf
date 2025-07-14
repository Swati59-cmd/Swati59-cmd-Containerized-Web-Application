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
  default     = "t2.small"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "lambda"
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}

variable "ecr_repo_url" {
  description = "ECR repository URI without tag"
  type        = string
  default     = "851725602228.dkr.ecr.us-east-1.amazonaws.com/devpython"
}





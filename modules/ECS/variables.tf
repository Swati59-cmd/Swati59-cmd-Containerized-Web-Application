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
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "lambda"
}

variable "image_tag" {
  description = "Docker image tag for ECS task definition"
  type        = string
}

variable "ecr_repo_name" {
  type    = string
  default = "stagepython"
}
variable "aws_account_id" {
  type    = number
  default = 851725602228
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
  default     = "arn:aws:acm:us-east-1:851725602228:certificate/84a5d456-bb51-4034-b2ff-414cf3fd5029"
}




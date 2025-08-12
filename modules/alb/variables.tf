variable "environment" {
  description = "Environment name"
  type        = string

}

variable "ami_id" {
  description = "AMI ID for ECS EC2 instances"
  type        = string

}
variable "alb_listener" {}


variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string

}



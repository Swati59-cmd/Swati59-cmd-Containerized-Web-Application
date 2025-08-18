variable "environment" {
  type        = string
  description = "Environment name (dev, stage, prod)"
}

variable "alb_sg_ids" {
  type        = list(string)
  description = "List of Security Group IDs for ALB"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of Public Subnet IDs for ALB placement"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for Target Group"
}
variable "acm_certificate_arn" {
  type = string
}
variable "alb_domain" {
  type = string
}

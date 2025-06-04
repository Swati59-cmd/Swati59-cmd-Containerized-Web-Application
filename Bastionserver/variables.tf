variable "instance_type" {
  description = "Bastion instance type"
  type        = string
  default     = "t2.medium"
}

variable "public_subnet_id" {
  description = "Subnet ID for the bastion"
  type        = string
  default     = "subnet-0b1455777aa0843bc"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0a9e201ac79b1b89a"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "lambda"
}
variable "subnet_ids" {
  description = "List of Public subnet for ALB"
  type        = list(string)
  default     = ["subnet-0b1455777aa0843bc", "subnet-0224b8b3343395f38"]
}
variable "ami" {
  type    = string
  default = "ami-02457590d33d576c3"
}

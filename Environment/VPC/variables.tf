variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}
variable "instance_type" {
  description = "Bastion instance type"
  type        = string
  default     = "t2.micro"
}
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "lambda"
}

variable "ami" {
  type    = string
  default = "ami-0cbbe2c6a1bb2ad63"
}





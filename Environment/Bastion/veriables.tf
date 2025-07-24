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
  type    = number
  default = "ami-0cbbe2c6a1bb2ad63"
}

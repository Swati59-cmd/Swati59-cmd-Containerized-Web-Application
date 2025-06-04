variable "env" {
  type    = string
  default = "main"
}
variable "bucket_name" {
  type    = string
  default = "swatidemomain"
}

variable "github_branch" {
  type    = string
  default = "main"
}

variable "ecs_cluster" {
  type    = string
  default = "main-ecs-cluster"
}
variable "ecs_service" {
  type    = string
  default = "main-service"
}

variable "aws_account_id" {
  type    = number
  default = 648908580279
}


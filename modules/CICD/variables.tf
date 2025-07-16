variable "env" {
  type    = string
  default = "dev"
}


variable "github_branch" {
  type    = string
  default = "dev"
}

variable "ecs_cluster" {
  type    = string
  default = "dev-ecs-cluster"
}
variable "ecs_service" {
  type    = string
  default = "dev-service"
}

variable "aws_account_id" {
  type    = number
  default = 851725602228
}


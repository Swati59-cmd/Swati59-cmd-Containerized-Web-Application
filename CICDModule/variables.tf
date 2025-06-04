variable "env" {
  type    = string
  default = "stage"
}
variable "bucket_name" {
  type = string

}

variable "github_branch" {
  type    = string
  default = "stage"
}

variable "ecs_cluster" {
  type    = string
  default = "stage-ecs-cluster"

}
variable "ecs_service" {
  type    = string
  default = "stage-service"
}

variable "aws_account_id" {
  type    = number
  default = 648908580279
}


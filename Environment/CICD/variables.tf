variable "env" {
  type = string
}
variable "bucket_name" {
  type    = string
  default = "devbucketcicd"
}

variable "github_branch" {
  type = string

}

variable "ecs_cluster" {
  type = string

}
variable "ecs_service" {}

variable "aws_account_id" {
  type    = number
  default = 851725602228
}


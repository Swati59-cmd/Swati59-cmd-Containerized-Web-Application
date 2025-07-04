terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "ECS-Main/terraform.tfstate"
    region = "us-east-1"

  }
}

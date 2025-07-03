terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "ECS/terraform.tfstate"
    region = "us-east-1"

  }
}

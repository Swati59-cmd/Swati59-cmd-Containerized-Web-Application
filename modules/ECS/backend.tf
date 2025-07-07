terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "ECS-main/terraform.tfstate"
    region = "us-east-1"

  }
}






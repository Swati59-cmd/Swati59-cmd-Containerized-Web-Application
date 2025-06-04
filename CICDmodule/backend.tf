terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "Pipline/terraform.tfstate"
    region = "us-east-1"

  }
}

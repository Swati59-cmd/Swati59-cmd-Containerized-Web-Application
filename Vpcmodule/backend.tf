terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"

  }
}

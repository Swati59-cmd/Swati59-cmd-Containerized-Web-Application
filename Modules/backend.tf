terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "vpc-stage/terraform.tfstate"
    region = "us-east-1"

  }
}

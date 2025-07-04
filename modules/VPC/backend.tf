terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "vpc-main/terraform.tfstate"
    region = "us-east-1"

  }
}

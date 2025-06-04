terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "CICD-stage/terraform.tfstate"
    region = "us-east-1"

  }
}

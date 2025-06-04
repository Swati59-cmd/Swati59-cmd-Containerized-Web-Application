terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "CICD-main/terraform.tfstate"
    region = "us-east-1"

  }
}

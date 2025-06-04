terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "Bastion/terraform.tfstate"
    region = "us-east-1"

  }
}

terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "vpc-stage/terraform.tfstate"
    region = "us-east-1"

  }
}

terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "vpc-main/terraform.tfstate"
    region = "us-east-1"

  }
}

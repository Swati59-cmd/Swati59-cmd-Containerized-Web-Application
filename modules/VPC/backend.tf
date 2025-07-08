terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "vpc-main/terraform.tfstate"
    region = "eu-north-1"

  }
}

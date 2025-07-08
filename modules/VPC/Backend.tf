terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "vpc/terraform.tfstate"
    region = "eu-north-1"

  }
}

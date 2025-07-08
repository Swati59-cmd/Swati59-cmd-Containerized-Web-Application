terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "vpc/terraform.tfstate"
    region = "ap-south-1"

  }
}

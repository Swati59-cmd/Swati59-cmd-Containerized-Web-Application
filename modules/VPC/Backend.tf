terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "vpc-stage/terraform.tfstate"
    region = "eu-east-1"

  }
}

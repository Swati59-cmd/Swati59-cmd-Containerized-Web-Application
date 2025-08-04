terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "vpc-main/terraform.tfstate"
    region = "us-east-1"

  }
}

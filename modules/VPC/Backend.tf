terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"

  }
}

terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "Pipline/terraform.tfstate"
    region = "us-east-1"

  }
}

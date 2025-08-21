terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "MainEnv/terraform.tfstate"
    region = "us-east-1"

  }
}

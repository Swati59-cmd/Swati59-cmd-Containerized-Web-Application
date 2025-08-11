terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "DevEnv/terraform.tfstate"
    region = "us-east-1"

  }
}

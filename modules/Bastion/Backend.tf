terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "Bastion/terraform.tfstate"
    region = "us-east-1"

  }
}

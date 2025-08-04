terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "ECS/terraform.tfstate"
    region = "us-east-1"

  }
}

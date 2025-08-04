terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "ECS-main/terraform.tfstate"
    region = "us-east-1"

  }
}





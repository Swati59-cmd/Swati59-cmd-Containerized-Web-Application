terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "ECS/terraform.tfstate"
    region = "ap-south-1"

  }
}

terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "ECS/terraform.tfstate"
    region = "eu-north-1"

  }
}

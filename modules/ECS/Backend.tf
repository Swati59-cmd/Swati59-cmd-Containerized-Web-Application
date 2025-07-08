terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "ECS/terraform.tfstate"
    region = "us-east-1"

  }
}

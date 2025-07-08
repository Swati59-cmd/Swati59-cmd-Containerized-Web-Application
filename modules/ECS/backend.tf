terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "ECS-main/terraform.tfstate"
    region = "us-east-1"

  }
}






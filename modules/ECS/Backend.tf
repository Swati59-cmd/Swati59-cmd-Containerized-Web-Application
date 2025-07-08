terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "ECSStage/terraform.tfstate"
    region = "us-east-1"

  }
}

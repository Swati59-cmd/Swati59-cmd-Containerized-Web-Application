terraform {
  backend "s3" {
    bucket = "swatistatefile"
    key    = "ECSStage/terraform.tfstate"
    region = "eu-north-1"

  }
}

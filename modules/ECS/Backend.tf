terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "ECSStage/terraform.tfstate"
    region = "eu-north-1"

  }
}

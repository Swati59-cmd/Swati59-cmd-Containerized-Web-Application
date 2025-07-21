terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "ECSStage/terraform.tfstate"
    region = "us-east-1"

  }
}

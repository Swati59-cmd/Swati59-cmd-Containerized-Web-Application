terraform {
  backend "s3" {
    bucket = "statefilevpc"
    key    = "ECSStage/terraform.tfstate"
    region = "us-east-1"

  }
}

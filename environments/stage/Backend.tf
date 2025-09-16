terraform {
  backend "s3" {
    bucket = "statefiledemo2"
    key    = "StageEnv/terraform.tfstate"
    region = "us-east-1"

  }
}

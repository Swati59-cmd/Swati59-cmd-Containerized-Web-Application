terraform {
  backend "s3" {
    bucket = "statefiledemo2"
    key    = "MainEnv/terraform.tfstate"
    region = "us-east-1"

  }
}

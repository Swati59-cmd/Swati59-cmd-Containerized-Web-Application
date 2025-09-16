terraform {
  backend "s3" {
    bucket = "statefiledemo2"
    key    = "DevEnv/terraform.tfstate"
    region = "us-east-1"

  }
}

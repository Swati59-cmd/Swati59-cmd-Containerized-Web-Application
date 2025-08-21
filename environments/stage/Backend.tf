terraform {
  backend "s3" {
    bucket = "swatitfstate"
    key    = "StageEnv/terraform.tfstate"
    region = "us-east-1"

  }
}

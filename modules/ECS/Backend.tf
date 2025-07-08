terraform {
  backend "s3" {
    bucket = "swati-tfstate-20250708"
    key    = "ECS/terraform.tfstate"
    region = "ap-south-1"

  }
}

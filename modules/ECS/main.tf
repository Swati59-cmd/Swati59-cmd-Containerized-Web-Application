module "ECSdemo" {
  source        = "../../Environment/ECS"
  environment   = "dev"
  ecr_repo_name = "devpython"
  image_tag     = var.image_tag


}





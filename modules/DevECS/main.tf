module "ECSdemo" {
  source        = "../../Environment/dev/ECS"
  environment   = "dev"
  ecr_repo_name = "devpython"
  #image_tag     = var.image_tag
}





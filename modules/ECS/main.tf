module "ECSdemo" {
  source        = "../../Environment/ECS"
  environment   = var.environment
  image_tag     = var.image_tag
  ecr_repo_url  = var.ecr_repo_url
  instance_type = var.instance_type
  key_name      = var.key_name

}





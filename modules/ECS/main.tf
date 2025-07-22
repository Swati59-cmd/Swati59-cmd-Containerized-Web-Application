module "EcsDemo" {
  source        = "../../Environment/ECS"
  environment   = var.environment
  ecr_repo_name = "mainpython"
  image_tag     = var.image_tag




}





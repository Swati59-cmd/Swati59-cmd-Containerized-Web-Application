module "ECSP" {
  source        = "../../Environment/ECS"
  environment   = var.environment
  ecr_repo_name = "stagepython"
  image_tag     = var.image_tag
}













module "ECSdemo" {
  source        = "../../Environments/ECS"
  environment   = "dev"
  ecr_repo_name = "devpython"


}





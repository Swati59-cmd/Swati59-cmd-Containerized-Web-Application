module "cicd" {
  source         = "../../Environment/CICD"
  env            = "dev"
  github_branch  = var.github_branch
  ecs_cluster    = var.ecs_cluster
  ecs_service    = var.ecs_service
  aws_account_id = var.aws_account_id
}

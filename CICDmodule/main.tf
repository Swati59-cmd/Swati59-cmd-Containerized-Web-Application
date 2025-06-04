module "cicd" {
  source         = "../../Module/CICD-Dev"
  env            = "dev"
  bucket_name    = var.bucket_name
  github_branch  = var.github_branch
  ecs_cluster    = var.ecs_cluster
  ecs_service    = var.ecs_service
  aws_account_id = var.aws_account_id
}

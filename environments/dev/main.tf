module "alb" {
  source              = "../../modules/alb"
  environment         = var.environment
  ami_id              = var.ami_id
  acm_certificate_arn = var.acm_certificate_arn
}

module "ecs" {
  source         = "../../modules/ecs"
  aws_region     = var.aws_region
  environment    = var.environment
  key_name       = var.key_name
  ecr_repo_name  = var.ecr_repo_name
  instance_type  = var.instance_type
  aws_account_id = var.aws_account_id
}

module "sequrity" {
  source = "../../modules/sequrity"
}

module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

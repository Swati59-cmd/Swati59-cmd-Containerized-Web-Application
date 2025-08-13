module "alb" {
  source               = "../../modules/alb"
  environment          = var.environment
  ami_id               = var.ami_id
  acm_certificate_arn  = var.acm_certificate_arn
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  vpc_cidr             = var.vpc_cidr

}

module "ecs" {
  source               = "../../modules/ECS"
  target_group_arn     = module.alb.target_group_arn
  aws_region           = var.aws_region
  environment          = var.environment
  key_name             = var.key_name
  ecr_repo_name        = var.ecr_repo_name
  instance_type        = var.instance_type
  aws_account_id       = var.aws_account_id
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  acm_certificate_arn  = var.acm_certificate_arn
  ami_id               = var.ami_id
  vpc_cidr             = var.vpc_cidr
  alb_listener         = module.alb.listener_arn

}

/*module "sequrity" {
  source               = "../../modules/sequrity"
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  vpc_cidr             = var.vpc_cidr
}

module "vpc" {
  source               = "../../modules/VPC"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}*/

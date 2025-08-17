# Create VPC
module "vpc" {
  source               = "../../modules/VPC"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]

}

# Create Security Groups
module "securitydemo1" {
  source      = "../../modules/sequrity"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

# Create ALB
module "albdemo" {
  source            = "../../modules/alb"
  environment       = var.environment
  alb_sg_ids        = [module.securitydemo1.ecs_alb_sg_id]
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id

}

data "aws_caller_identity" "current" {}

module "ecs" {
  source = "../../modules/ECS"

  environment        = var.environment
  ecr_repo_name      = var.ecr_repo_name
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  ecs_sg_ids         = [module.securitydemo1.ecs_alb_sg_id]
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn   = module.albdemo.target_group_arn
  alb_listener_arn   = module.albdemo.alb_listener_arn

  aws_region     = var.aws_region
  aws_account_id = data.aws_caller_identity.current.account_id
}


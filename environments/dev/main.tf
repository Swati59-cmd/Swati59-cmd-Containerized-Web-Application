# Create VPC
module "vpc" {
  source               = "../../modules/vpc"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = ["ap-south-1a", "ap-south-1b"]

}

# Create Security Groups
module "security" {
  source      = "../../modules/security"
  environment = var.environment
  vpc_id      = modules.VPC.vpc_id
}

# Create ALB
module "albdemo" {
  source            = "../../modules/alb"
  environment       = var.environment
  alb_sg_ids        = [module.securitydemo.alb_sg_id]
  public_subnet_ids = module.vpcdemo.public_subnet_ids
  vpc_id            = module.vpcdemo.vpc_id
}

module "ecs" {
  source             = "../../modules/ecs"
  environment        = var.environment
  ecr_repo_name      = var.ecr_repo_name
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  ecs_sg_ids         = [module.security.ecs_sg_id]
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  alb_listener_arn   = module.alb.alb_arn
}

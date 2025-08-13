# Create VPC
module "vpc" {
  source               = "../../modules/VPC"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = ["ap-south-1a", "ap-south-1b"]

}

# Create Security Groups
module "securitydemo1" {
  source      = "../../modules/sequrity"
  environment = var.environment
  vpc_id      = modules.vpc.vpc_id
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
  source             = "../../modules/ECS"
  environment        = var.environment
  ecr_repo_name      = var.ecr_repo_name
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  ecs_sg_ids         = modules.security.alb_sg_id
  private_subnet_ids = modules.VPC.public_subnet_ids
  target_group_arn   = modules.alb.target_group_arn
  alb_listener_arn   = modules.alb.alb_arn
}

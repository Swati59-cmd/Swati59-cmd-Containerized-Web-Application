

# VPC Module
module "vpcdemo" {
  source               = "../../modules/VPC"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# Security Groups Module
module "securitydemo" {
  source = "../../modules/security"
  vpc_id = module.vpcdemo.vpc_id
}

# ALB Module
module "alb" {
  source = "../../modules/alb"
  //vpc_id         = module.vpcdemo.vpc_id
  //public_subnets = module.vpcdemo.public_subnet_ids
  //alb_sg_id      = module.securitydemo.alb_sg_id
  public_subnet_ids   = module.vpcdemo.public_subnet_ids
  ecs_alb_sg          = module.sequritydemo.ecs_alb_sg
  acm_certificate_arn = var.acm_certificate_arn
}

# ECS Module
module "ecs" {
  source             = "../../modules/ECS"
  vpc_id             = module.vpcdemo.vpc_id
  private_subnets    = module.vpcdemo.private_subnet_ids
  ecs_sg_id          = module.securitydemo.ecs_sg_id
  target_group_arn   = module.alb.target_group_arn
  alb_listener_arn   = module.alb.listener_arn
  ecs_instance_sg_id = module.securitydemo.ecs_instance_sg_id
}

module "ECSP" {
  source = "../../Module/ECS-Stage"

  environment        = var.environment
  image              = var.image
  instance_type      = var.instance_type
  key_name           = var.key_name
  private_subnet_ids = var.private_subnet_ids
  vpc_id             = var.vpc_id



}





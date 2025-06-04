module "ECSdemo" {
  source = "../ECS"

  environment   = var.environment
  image         = var.image
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_ids    = var.subnet_ids
  vpc_id        = var.vpc_id



}





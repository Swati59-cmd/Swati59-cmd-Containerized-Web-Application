module "ECSP" {
  source = "../../Module/ECS-Main"

  environment   = var.environment
  image         = var.image
  instance_type = var.instance_type
  key_name      = var.key_name




}





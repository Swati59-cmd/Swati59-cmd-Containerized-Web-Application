module "ECSP" {
  source = "../../Environment/ECS"

  environment   = var.environment
  image         = var.image
  instance_type = var.instance_type
  key_name      = var.key_name
}













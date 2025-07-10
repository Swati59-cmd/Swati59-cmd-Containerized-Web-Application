module "ECSdemo" {
  source = "../../Environment/ECS"

  environment = var.environment
  #mage         = var.image_uri
  instance_type = var.instance_type
  key_name      = var.key_name

}





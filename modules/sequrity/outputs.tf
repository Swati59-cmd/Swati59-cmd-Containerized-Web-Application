output "ecs_instance_sg_id" {
  value = aws_security_group.ecs_instance_sg.id
}

output "ecs_alb_sg_id" {
  value = aws_security_group.ecs_alb_sg.id
}

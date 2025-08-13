output "ecs_alb_sg_id" {
  value = aws_security_group.ecs_alb_sg.id
}

output "ecs_service_sg_id" {
  value = aws_security_group.ecs_service_sg.id
}

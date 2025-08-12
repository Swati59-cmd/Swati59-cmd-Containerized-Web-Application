output "ecs_instance_sg_id" {
  value = aws_security_group.ecs_instance_sg.id
}
output "ecs-alb-sg" {
  value = aws_security_group.alb_sg.id
}

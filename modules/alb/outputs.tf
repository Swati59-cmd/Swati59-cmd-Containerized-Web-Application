
output "listener_arn" {
  value = aws_lb_listener.listener
}
output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

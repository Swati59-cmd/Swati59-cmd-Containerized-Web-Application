output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "alb_arn" {
  value = aws_lb.this.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}
output "alb_listener_arn" {
  value = aws_lb_listener.http.arn
}
//output "acm_certificate_arn" {
//value = aws_acm_certificate.cert.arn
//}

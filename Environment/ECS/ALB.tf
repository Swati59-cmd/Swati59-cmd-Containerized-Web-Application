resource "aws_lb" "alb" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc_main.public_subnet_ids
  security_groups    = [aws_security_group.alb_sg.id]
  tags = {
    Name        = "${var.environment}-listener"
    Environment = var.environment
    Project     = "swati-project"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc_main.vpc_id

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

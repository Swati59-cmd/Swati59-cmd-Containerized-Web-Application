############################################
# Application Load Balancer Module
############################################

resource "aws_lb" "this" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg_ids        # Passed dynamically from root/module
  subnets            = var.public_subnet_ids # Passed dynamically from VPC module
  idle_timeout       = 60

  tags = {
    Name        = "${var.environment}-alb"
    Environment = var.environment
    Project     = "swati-project"
  }
}

############################################
# Target Group
############################################
resource "aws_lb_target_group" "ecs_tg" {
  name        = "${var.environment}-ecs-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name        = "${var.environment}-ecs-tg"
    Environment = var.environment
  }
}


############################################
# Listener (HTTP)
############################################
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:851725602228:certificate/cb556548-3b63-4ca3-b5ae-9f6a1ab4dbdd"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}


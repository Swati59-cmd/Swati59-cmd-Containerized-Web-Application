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
  target_type = "ip"       # Since we are using ECS EC2, not Fargate
  vpc_id      = var.vpc_id # Passed from VPC module output

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
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

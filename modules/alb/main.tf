resource "aws_lb" "alb" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpcdemo.public_subnet_ids
  security_groups    = module.sequritydemo.ecs-alb-sg.id
  tags = {
    Name        = "${var.environment}-alb"
    Projectname = "swati project"
  }

}

resource "aws_lb_target_group" "tg" {
  name        = "${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = module.vpc.vpc_id
  tags = {
    Name        = "${var.environment}"
    Projectname = "swati project"
  }

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
  tags = {
    Name        = "${var.environment}"
    Projectname = "swati project"
  }
}

module "vpcdemo" {
  source               = "../VPC"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}
module "sequritydemo" {
  source = "../sequrity"
}

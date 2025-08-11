resource "aws_security_group" "ecs_instance_sg" {
  name   = "Projectecs-sg1"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow port 5000 for Flask app"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Projectecs-sg1"
    Project = "swati-project"
  }
}
resource "aws_security_group" "alb_sg" {
  name        = "dev-alb-sg"
  description = "Allow public access to ALB"
  vpc_id      = module.vpc.vpc_id



  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-alb-sg"
  }
}

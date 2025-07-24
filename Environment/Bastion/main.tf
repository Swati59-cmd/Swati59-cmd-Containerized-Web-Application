resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = module.vpcmodule.public_subnet_ids[0]
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "Stage-Bastion-Server"
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from my IP to bastion host"
  vpc_id      = module.vpcmodule.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "bastion-sg"
    Project = "swati"
  }
}
module "vpcmodule" {
  source               = "../VPC"
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.10.0/24", "10.1.11.0/24"]
  private_subnet_cidrs = ["10.1.20.0/24", "10.1.21.0/24"]
}

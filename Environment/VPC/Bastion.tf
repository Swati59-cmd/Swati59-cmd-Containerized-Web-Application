resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
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
  vpc_id      = aws_vpc.main.id

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


resource "aws_security_group" "ecs_instance_sg" {
  name   = "Stage-Bastion"
  vpc_id = aws_vpc.main.id

  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port   = 5000
    to_port     = 5000
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
    Name = "Projectecs-Bastion"
  }
}

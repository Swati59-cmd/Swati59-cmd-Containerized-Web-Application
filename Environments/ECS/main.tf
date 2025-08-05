resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-ecs-cluster"
  tags = {
    Name        = "${var.environment}-listener"
    Environment = var.environment
    Project     = "swati-project"
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.environment}-ecs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  tags = {
    Name        = "${var.environment}-listener"
    Environment = var.environment
    Project     = "swati-project"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.environment}-ecs-instanceDemo5"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_launch_template" "ecs" {
  name_prefix            = "${var.environment}-ecs-launch-"
  image_id               = data.aws_ssm_parameter.ecs_ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ecs_instance_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.environment}-ecs-instance"
      Environment = var.environment
      Project     = "swati-project"
    }
  }
  tags = {
    Name        = "${var.environment}-ecs-launch-template"
    Environment = var.environment
    Project     = "swati-project"
  }
}


resource "aws_autoscaling_group" "ecs_asg" {
  name                = "${var.environment}-ecs-asg"
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2
  vpc_zone_identifier = module.vpc.public_subnet_ids
  health_check_type   = "EC2"
  force_delete        = true

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-ecs-instance"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "swati-project"
    propagate_at_launch = true
  }
}



resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  tags = {
    Name        = "${var.environment}-ecs-task-execution-role"
    Environment = var.environment
    Project     = "swati-project"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_exec_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.environment}-app"
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu                      = "128"
  memory                   = "256"

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo_name}"
      essential = true
      portMappings = [
        {
          containerPort = 5000,
          hostPort      = 5000

        }
      ]

    }
  ])


  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "service" {
  name            = "${var.environment}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "EC2"
  network_configuration {
    subnets         = module.vpc.public_subnet_ids
    security_groups = [aws_security_group.ecs_instance_sg.id]

    assign_public_ip = false # or true if needed
  }


  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "app"
    container_port   = 5000
  }


  depends_on = [aws_lb_listener.listener]
}
data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}


module "vpc" {
  source               = "../../modules/VPC"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
}


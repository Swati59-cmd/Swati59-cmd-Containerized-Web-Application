resource "aws_iam_role" "codepipeline_role" {
  name = "${var.env}-codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_ReadOnlyAccess"
}
resource "aws_iam_role" "codebuild_role" {
  name = "${var.env}-codebuild-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}


resource "aws_iam_policy" "codebuild_s3_access" {
  name = "${var.env}-CodeBuildS3Access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::devbucketcicd",
          "arn:aws:s3:::devbucketcicd/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_codepipeline_s3" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codebuild_s3_access.arn
}
resource "aws_iam_role_policy_attachment" "attach_codebuild_s3_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_s3_access.arn
}

resource "aws_iam_policy" "allow_codestar_connection" {
  name        = "AllowUseCodeStarConnection"
  description = "Allows CodePipeline to use the CodeStar connection"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codestar-connections:UseConnection"
        ]
        Resource = "arn:aws:codeconnections:us-east-1:851725602228:connection/ab62ca85-1804-4eef-a633-058b9e8ff4cf"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_codestar_connection" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.allow_codestar_connection.arn
}




resource "aws_iam_policy" "codepipeline_codebuild_access" {
  name = "${var.env}-CodePipelineStartBuildAccess"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "codebuild:StartBuild",
        "codebuild:BatchGetBuilds"
      ],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_codebuild_access_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_codebuild_access.arn
}

# IAM for CodeBuild

resource "aws_iam_policy" "codebuild_logs_policy" {
  name        = "CodeBuildCloudWatchLogsPolicy"
  description = "Allows CodeBuild to write logs to CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = [
          "arn:aws:logs:us-east-1:${var.aws_account_id}:log-group:/aws/codebuild/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_logs_policy_to_codebuild" {
  role       = aws_iam_role.codebuild_role.name # This must match the actual CodeBuild role name in your TF
  policy_arn = aws_iam_policy.codebuild_logs_policy.arn
}


resource "aws_iam_policy" "codebuild_s3_read" {
  name = "${var.env}-CodeBuildS3ReadAccess"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        Resource = "arn:aws:s3:::artifact-devproject/dev-Pipeline/*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:ListBucket",
        Resource = "arn:aws:s3:::artifact-devproject"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_s3_read_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_s3_read.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr_access" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# ECS Deploy access for CodePipeline
resource "aws_iam_policy" "codepipeline_ecs_access" {
  name = "${var.env}-CodePipelineECSAccess"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:RegisterTaskDefinition",
          "ecs:DescribeServices",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeTasks",
          "ecs:ListTasks",
          "ecs:UpdateService"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = "*",
        Condition = {
          StringLike = {
            "iam:PassedToService" = "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_ecs_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_ecs_access.arn
}

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

# Attach Managed Policies
resource "aws_iam_role_policy_attachment" "codepipeline_readonly" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "codebuild_developer_access" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}


resource "aws_iam_role_policy_attachment" "codebuild_ecr_access" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# 🔹 Custom S3 Access Policy for Artifact Bucket
resource "aws_iam_policy" "codepipeline_artifact_bucket_access" {
  name = "${var.env}-CodePipelineS3Access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid : "S3AccessToArtifactBucket",
        Effect : "Allow",
        Action : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:ListBucket",
          "s3:GetBucketAcl",
          "s3:GetBuketLocation"
        ],
        Resource : [
          "arn:aws:s3:::dev-artifact-devproject-851725602228",
          "arn:aws:s3:::dev-artifact-devproject-851725602228/dev-Pipeline/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_s3_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_artifact_bucket_access.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_s3_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codepipeline_artifact_bucket_access.arn
}

# 🔹 CodeStar Connection Usage
resource "aws_iam_policy" "codepipeline_codestar_connection" {
  name = "${var.env}-AllowCodeStarConnectionUse"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "codestar-connections:UseConnection",
      Resource = "arn:aws:codeconnections:us-east-1:851725602228:connection/ab62ca85-1804-4eef-a633-058b9e8ff4cf"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_codestar_connection_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_codestar_connection.arn
}

# 🔹 Allow CodePipeline to Start CodeBuild Jobs
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

# 🔹 CloudWatch Logs for CodeBuild
resource "aws_iam_policy" "codebuild_cloudwatch_logs" {
  name = "${var.env}-CodeBuildCloudWatchLogsAccess"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:us-east-1:851725602228:log-group:/aws/codebuild/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_cloudwatch_logs_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_cloudwatch_logs.arn
}

# 🔹 ECS Deployment Access for CodePipeline
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
        Effect   = "Allow",
        Action   = ["iam:PassRole"],
        Resource = "*",
        Condition = {
          StringLike = {
            "iam:PassedToService" : "ecs-tasks.amazonaws.com"
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

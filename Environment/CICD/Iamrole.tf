
resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket        = "${var.env}-artifact-devproject-${var.aws_account_id}"
  force_destroy = true
}


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

resource "aws_iam_policy" "codepipeline_artifact_access" {
  name = "${var.env}-CodePipelineArtifactS3Access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "S3ArtifactReadWrite",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.codepipeline_artifacts.bucket}/dev-Pipeline/*"
        ]
      },
      {
        Sid      = "S3ArtifactList",
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = "arn:aws:s3:::${aws_s3_bucket.codepipeline_artifacts.bucket}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_s3_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_artifact_access.arn
}

# Allow CodeStar Connection
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

# CodePipeline can start CodeBuild
resource "aws_iam_policy" "codepipeline_codebuild_access" {
  name = "${var.env}-CodePipelineStartBuildAccess"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["codebuild:StartBuild", "codebuild:BatchGetBuilds"],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_codebuild_access_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_codebuild_access.arn
}

# ECS Deploy Access
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

# ---------------------
# CodeBuild IAM Role
# ---------------------

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
        Sid    = "S3ArtifactAccess",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        Resource = "arn:aws:s3:::${aws_s3_bucket.codepipeline_artifacts.bucket}/dev-Pipeline/*"
      },
      {
        Sid      = "S3ArtifactList",
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = "arn:aws:s3:::${aws_s3_bucket.codepipeline_artifacts.bucket}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_codebuild_s3_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_s3_access.arn
}

resource "aws_iam_policy" "codebuild_cloudwatch_logs" {
  name = "${var.env}-CodeBuildCloudWatchLogsAccess"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        Resource = "arn:aws:logs:us-east-1:${var.aws_account_id}:log-group:/aws/codebuild/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_cloudwatch_logs_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_cloudwatch_logs.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr_access" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = var.bucket_name
}

resource "aws_codestarconnections_connection" "github" {
  name          = "cicd-github"
  provider_type = "GitHub"
}

resource "aws_codebuild_project" "my_build" {
  name         = "${var.env}-CodeBuildProject"
  service_role = aws_iam_role.codebuild_role.arn
  description  = "Build project"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "648908580279"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}

resource "aws_codepipeline" "my_pipeline" {
  name     = "${var.env}-Pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifacts.bucket
    type     = "S3"
  }



  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = "arn:aws:codeconnections:us-east-1:648908580279:connection/c1d3b7ac-4e84-4c71-95fa-694ee7132651"
        FullRepositoryId = "Swati59-cmd/Swati59-cmd-Containerized-Web-Application"
        BranchName       = var.github_branch
        DetectChanges    = "true"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.my_build.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "DeployToECS"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName = var.ecs_cluster
        ServiceName = var.ecs_service
        FileName    = "imagedefinitions.json"
      }
    }
  }
}

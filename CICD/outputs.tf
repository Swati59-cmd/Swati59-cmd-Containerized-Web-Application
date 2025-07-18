output "codebuild_project_name" {
  value = aws_codebuild_project.my_build.name
}

output "codepipeline_name" {
  value = aws_codepipeline.my_pipeline.name
}

output "artifact_bucket" {
  value = aws_s3_bucket.codepipeline_artifacts.bucket
}

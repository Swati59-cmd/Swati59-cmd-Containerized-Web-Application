# DevOps Intern Assessment Project

This repository contains a simple Flask web application that needs to be containerized and deployed to AWS ECS using Terraform and GitHub Actions.

## Task Requirements

1. Fork this repository
2. Create AWS infrastructure using the provided Terraform files
3. Set up a CI/CD pipeline using GitHub Actions
4. Successfully deploy the application to AWS ECS
5. Document your process and any troubleshooting steps

## Project Structure

- `app.py`: Simple Flask web application
- `templates/index.html`: HTML template for the web application
- `requirements.txt`: Python dependencies
- `Dockerfile`: Docker configuration for containerizing the application
-  Terraform configuration for AWS infrastructure
- `.github/workflows/deploy.yml`: GitHub Actions workflow for CI/CD

## Getting Started

1. Make sure you have the following prerequisites:
   - AWS account with appropriate permissions
   - Docker installed locally
   - Terraform installed locally
   - Git

2. Fork this repository to your GitHub account

3. Clone your forked repository:
   ```
   git clone https://github.com/AmitBarate07/devops-intern-assessment.git
   cd devops-intern-assessment
   ```

4. Set up AWS credentials as GitHub secrets:
   - AWS_ACCESS_KEY_ID
   - AWS_SECRET_ACCESS_KEY

5. Build the docker image and test it locally:
   ```
Using docker build && docker run command.
   ```

6. Initialize and apply Terraform configuration:
   ```
   terraform init
   terraform apply
   ```

7. Push your changes to trigger the GitHub Actions workflow

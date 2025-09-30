environment         = "dev"
ami_id              = "ami-0953476d60561c955"
instance_type       = "t2.micro"
key_name            = "lambda"
ecr_repo_name       = "devpython"
aws_account_id      = 180961898054
aws_region          = "us-east-1"
acm_certificate_arn = "arn:aws:acm:us-east-1:180961898054:certificate/db1781af-a903-47e2-b266-e2ec9896b252"
vpc_cidr            = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.101.0/24",
  "10.0.102.0/24"
]
//alb_domain = "dev.swati.visiontechguru.in"

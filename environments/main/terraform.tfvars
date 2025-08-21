environment    = "main"
ami_id         = "ami-0953476d60561c955"
instance_type  = "t2.micro"
key_name       = "lambda"
ecr_repo_name  = "mainpython"
aws_account_id = 851725602228
aws_region     = "us-east-1"
//acm_certificate_arn = "arn:aws:acm:us-east-1:851725602228:certificate/cb556548-3b63-4ca3-b5ae-9f6a1ab4dbdd"
vpc_cidr = "10.3.0.0/16"

public_subnet_cidrs = [
  "10.1.1.0/24",
  "10.1.2.0/24"
]

private_subnet_cidrs = [
  "10.1.10.0/24",
  "10.1.11.0/24"
]
//alb_domain = "dev.swati.visiontechguru.in"

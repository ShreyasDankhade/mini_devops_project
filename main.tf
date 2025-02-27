provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for Data Storage
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-s3-data-bucket"
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier          = "mydbinstance"
  allocated_storage   = 10
  engine             = "mysql"
  instance_class      = "db.t2.micro"
  username           = "admin"
  password           = "mypassword"
  publicly_accessible = true
}

# ECR Repository for Docker Image
resource "aws_ecr_repository" "ecr_repo" {
  name = "s3-to-rds"
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": { "Service": "lambda.amazonaws.com" },
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Lambda Function
resource "aws_lambda_function" "lambda_function" {
  function_name    = "s3_to_rds_lambda"
  image_uri       = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  role            = aws_iam_role.lambda_role.arn
  package_type    = "Image"
  timeout         = 30
}

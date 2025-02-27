provider "aws" {
  region = "ap-south-1"
}

# S3 Bucket for Data Storage
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-s3-data-bucket"  # Ensure this name is unique
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier          = "mydbinstance"
  allocated_storage    = 20  # Increased storage for better compatibility
  engine              = "mysql"
  engine_version      = "8.0"  # Specify a supported MySQL version
  instance_class      = "db.t3.micro"
  username            = "admin"
  password            = "mypassword"  # Consider using a sensitive variable for security
  publicly_accessible  = true
  skip_final_snapshot  = true  # Set to false for production
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

# Attach the AWSLambdaBasicExecutionRole policy to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# Attach additional permissions to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"  # Attach full access policy
  role       = aws_iam_role.lambda_role.name
}

# Lambda Function
resource "aws_lambda_function" "lambda_function" {
  function_name    = "s3_to_rds_lambda"
  image_uri        = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  role             = aws_iam_role.lambda_role.arn
  package_type     = "Image"
  timeout          = 30
}

provider "aws" {
  region = "Add region accordingly"
}

# S3 Bucket for Data Storage
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "Name the bucket as per requirement"  # Ensure this name is unique
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier          = "mydbinstance" 
  allocated_storage    = 20  # Increased storage for better compatibility
  engine              = "mysql" # You can change the DB engine as per the need.
  engine_version      = "8.0"  # Specify a supported MySQL version
  instance_class      = "db.t3.micro" # You can change the instance class as per the need.
  username            = "UserName" 
  password            = "add password as per requirement"  # Consider using a sensitive variable for security
  publicly_accessible  = true
  skip_final_snapshot  = true  # Set to false for production
}

# ECR Repository for Docker Image
resource "aws_ecr_repository" "ecr_repo" {
  name = "ECR-repo-name"
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
 name = "role_name"


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


resource "aws_iam_policy" "lambda_policy" {
 name        = "lambda_execution_policy"
 description = "IAM policy for Lambda execution permissions"


 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Action": [
       "lambda:CreateFunction",
       "iam:PassRole",
       "s3:GetObject",
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "*"
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
  function_name    = "lambda_function_name"
  image_uri        = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  role             = aws_iam_role.lambda_role.arn
  package_type     = "Image"
  timeout          = 30
  handler          = "lambda_function.handler"
}

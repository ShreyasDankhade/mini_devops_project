provider "aws" {
  region = "your-region"
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "your-data-bucket"
  acl    = "private"
}

resource "aws_db_instance" "rds_instance" {
  identifier         = "rds-instance"
  engine             = "mysql"
  instance_class     = "db.t2.micro"
  allocated_storage  = 20
  username           = "admin"
  password           = "YourPassword123"
  skip_final_snapshot = true
}

resource "aws_ecr_repository" "app_repository" {
  name = "s3-to-rds-app"
}

resource "aws_lambda_function" "container_lambda" {
  function_name = "s3-to-rds-lambda"
  package_type  = "Image"
  image_uri     = "<aws_account_id>.dkr.ecr.your-region.amazonaws.com/s3-to-rds-app:latest"
  role          = aws_iam_role.lambda_exec.arn
  timeout       = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

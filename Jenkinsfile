pipeline {
    agent any
    environment {
        AWS_REGION = 'your-region'
        AWS_ACCOUNT_ID = 'your_aws_account_id'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/s3-to-rds-pipeline.git'
            }
        }
        stage('Terraform Init & Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t s3-to-rds-app .'
                sh 'docker tag s3-to-rds-app:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/s3-to-rds-app:latest'
            }
        }
        stage('Push to ECR') {
            steps {
                sh '''
                   aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                   docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/s3-to-rds-app:latest
                   '''
            }
        }
        stage('Deploy Lambda') {
            steps {
                // Optionally, trigger an update for your Lambda function via AWS CLI
                sh '''
                   aws lambda update-function-code --function-name s3-to-rds-lambda --image-uri $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/s3-to-rds-app:latest
                   '''
            }
        }
    }
    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed. Please check the logs.'
        }
    }
}

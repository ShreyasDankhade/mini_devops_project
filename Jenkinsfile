pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        AWS_ACCOUNT_ID = "920373006441"
        AWS_ACCESS_KEY_ID = "AKIA5MSUBSBUWHAV7GH2"  
        AWS_SECRET_ACCESS_KEY = "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"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ShreyasDankhade/go_digital_devops_project.git'
            }
        }

        stage('Verify AWS Credentials') {
            steps {
                sh '''
                echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
                echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
                '''
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                terraform init
                terraform apply -auto-approve
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t s3-to-rds .
                '''
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                docker tag s3-to-rds:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/s3-to-rds:latest
                docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/s3-to-rds:latest
                '''
            }
        }

        stage('Update Lambda Function') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                aws lambda update-function-code --function-name s3_to_rds_lambda --image-uri ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/s3-to-rds:latest
                '''
            }
        }
    }
}

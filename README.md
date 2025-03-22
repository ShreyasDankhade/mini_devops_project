# 🚀 Mini DevOps Project

This repository presents a practical implementation of a DevOps pipeline utilizing **Terraform**, **Docker**, and **Jenkins** to automate infrastructure provisioning and deployment workflows. The pipeline is configured to invoke an **AWS Lambda** _function_ through a **Python** script, which contains the core _logic_ of the Lambda function.

The primary objective of this project is to provide users with a hands-on understanding of core DevOps principles, including infrastructure as code (IaC), continuous integration, and automation within the context of serverless architecture.

---

## 🛠️ Technologies Used

- **Python:** Simple web application using Flask.
- **Docker:** Containerizing the application for consistent deployment.
- **Terraform:** Infrastructure as Code (IaC) tool for provisioning AWS infrastructure.
- **Jenkins:** Automating the Continuous Integration and Continuous Deployment (CI/CD) pipeline.
- **AWS:** Cloud platform to host application infrastructure.

---

## 📂 Project Structure

```
mini_devops_project/
├── app.py              # Python Flask web application
├── Dockerfile          # Instructions to build Docker image
├── Jenkinsfile         # Jenkins pipeline configuration
├── main.tf             # Terraform configuration for AWS infrastructure
└── README.md           # Documentation for project setup and use
```

---

## ✅ Prerequisites

Ensure the following are installed and configured:

- [AWS Account](https://aws.amazon.com/)
- [Terraform](https://www.terraform.io/downloads)
- [Docker](https://docs.docker.com/get-docker/)
- [Jenkins](https://www.jenkins.io/download/)

---

## ⚙️ Setup Instructions

## *Please perform a code review and implement the necessary changes to align with the specified requirements.*

### 1. Infrastructure Provisioning with Terraform

Terraform automates infrastructure creation on AWS.

```bash
# Navigate to the project directory
cd mini_devops_project

# Initialize Terraform
terraform init

# Review the infrastructure plan
terraform plan

# Apply Terraform configurations
terraform apply
```

### 2. Application Containerization with Docker

Docker ensures the application runs consistently across environments.

```bash
# Build Docker Image
docker build -t mini_devops_app .

# Run Docker Container
docker run -d -p 5000:5000 mini_devops_app
```

- Verify the application is running:
  ```bash
  curl http://localhost:5000
  ```

### 3. CI/CD Pipeline Setup with Jenkins

- Ensure Jenkins is running and install the necessary plugins:

  - Docker Pipeline
  - Terraform

- **Create a Jenkins Pipeline Job:**

  - Select "Pipeline" type job.
  - Configure the pipeline to use SCM and link to this repository.
  - Set pipeline script path as `Jenkinsfile`.

- **Run the Jenkins Pipeline**:

  - Trigger the build manually or via SCM webhooks.
  - Monitor the pipeline execution through Jenkins UI.

---

## 🔄 CI/CD Pipeline Workflow

The provided `Jenkinsfile` automates the following workflow:


- **Checkout**: Retrieves code from the repository.
- **Access the AWS Account** -  Authenticates and establishes access to the AWS environment.
- **Creates AWS S3 Bucket** - Provisions an S3 bucket for storing artifacts or other resources.
- **Creates AWS RDS Instance** - Sets up an Amazon RDS instance for database management.
- **Creates AWS ECR Repo** -  Creates an Amazon ECR repository to store Docker images.
- **Build Docker Image**: Containerizes the application.
- **Push Docker Image to ECR rope**: To a container registry AWS ECR.
- **Trigger AWS Lambda Function** - Triggers the Lambda Function.
- **Terraform Deploy**: Provisions the necessary infrastructure on AWS and deploys the Docker container.
- **Notification** : Configure notifications for pipeline success or failure.

---

## 🎯 Customization & Best Practices

- Replace placeholder AWS credentials and configuration details with your own in `main.tf`.
- Store sensitive data securely using environment variables or Jenkins secrets.
- Regularly monitor and clean up AWS resources to avoid unnecessary costs.

---

## 🛑 Troubleshooting

- **Docker Issues:** Ensure Docker is running and you have sufficient privileges.
- **Terraform Issues:** Confirm AWS credentials and permissions are properly configured.
- **Jenkins Pipeline Issues:** Check Jenkins logs and plugin compatibility.

---

## 📚 Resources

- [Terraform Documentation](https://www.terraform.io/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Jenkins Pipeline Guide](https://www.jenkins.io/doc/book/pipeline/)
- [AWS Getting Started](https://aws.amazon.com/getting-started/)

---

## 👥 Contributors
- **Shreyas Dankhade** (Repository Owner)
- Contributions are welcome! Feel free to fork and submit pull requests.

---

## 📧 Contact
For questions or support, contact Shreyas Dankhade at shreyasdankhade75@gmail.com.


# 🚀 Mini DevOps Project

This repository demonstrates a practical implementation of a DevOps pipeline by integrating Terraform, Docker, and Jenkins to deploy a Python web application seamlessly. It is designed to help users understand and practice basic DevOps workflows and infrastructure management concepts.

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

## *Please do a Code Review to make changes as per the requirement.*

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
- **Build Docker Image**: Containerizes the application.
- **Push Docker Image** (Optional): To a container registry like Docker Hub or AWS ECR.
- **Terraform Deploy**: Provisions the necessary infrastructure on AWS and deploys the Docker container.
- **Notification** (Optional): Configure notifications for pipeline success or failure.

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


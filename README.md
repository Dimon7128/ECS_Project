# ESC_Project

# AWS Infrastructure Provisioning with Terraform

This project provisions a full AWS infrastructure stack using Terraform, including load balancers, ECS cluster, IAM roles, Lambda functions, RDS instances, and VPC configurations. After infrastructure provisioning, two Lambda functions are invoked: one to create a table in RDS and another to create a DNS record in Route 53 and attach an ALB to it.

## Architecture Overview

The Terraform setup organizes resources into modules for clarity and maintainability. The infrastructure consists of the following modules:

- **ALB (Application Load Balancer)**
- **ECS Cluster**
- **IAM (Identity and Access Management)**
- **RDS (Relational Database Service)**
- **VPC (Virtual Private Cloud)**

![Alt text](https://github.com/Dimon7128/ESC_Project/blob/main/Architecture.pdf)


Each module is responsible for provisioning its respective AWS resources.

## Prerequisites

Before running this Terraform project, ensure that you have the following:

- Terraform v0.12.x or higher installed
- Docker installed
- AWS CLI configured with appropriate credentials
- Adequate permissions to create the resources defined in the Terraform configurations
- Amazon Route 53 Hosted Zone
- Private ECR repository
## Lambda Function:
1. Navigate to the directory where you want to clone the repository.
2. Run the git clone command with the URL of the repository:
```markdown
git clone https://github.com/Dimon7128/services.git
```
3. Upload the lambda_function.zip to s3 bucket.
```markdown
cd lambda
aws s3 cp lambda_function.zip s3://your-bucket-name/
```
## Push Docker Images to private ECR:
1. Create the backend docker image:
```markdown
cd backend
docker build -t my-backend-image .
```
2. Authenticate with ECR:
```markdown
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```
3. Tag and Push Docker Image:
```markdown
docker tag my-backend-image <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/my-backend-image
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/my-backend-image
```
4. Repeat for the nginx image.

## Usage

To use this project, follow these steps:

1. Clone this repository to your local repository
```markdown
git clone https://github.com/Dimon7128/ESC_Project.git
```
2.  Initialize Terraform:
```markdown
nano terraform.tfvars
```
And adjust the deafult values and env variable accordingly to your env and requirements.

3. Inizialize terraform and apply:
```markdown
terraform init
terraform apply
```



## Project Structure

- `main.tf` - Root module that calls other modules to provision AWS resources.
- `modules/` - Contains submodules, each of which provisions a part of the infrastructure:
  - `alb/` - Configures the Application Load Balancer.
  - `ecs-cluster/` - Sets up the ECS Cluster and associated services.
  - `iam/` - Manages IAM roles and policies for the ECS tasks and Lambda functions.
  - `rds/` - Provisions RDS instances and related configurations.
  - `vpc/` - Sets up the VPC, including subnets, route tables, and internet gateways.
- `outputs.tf` - Defines outputs after the Terraform apply is complete.
- `README.md` - Provides information about the project and setup instructions.


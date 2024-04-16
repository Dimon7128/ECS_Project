# ESC_Project

# AWS Infrastructure Provisioning with Terraform

This project provisions a full AWS infrastructure stack using Terraform, including load balancers, ECS cluster, IAM roles, Lambda functions, RDS instances, and VPC configurations. After infrastructure provisioning, two Lambda functions are invoked: one to create a table in RDS and another to create a DNS record in Route 53 and attach an ALB to it.

## Architecture Overview

The Terraform setup organizes resources into modules for clarity and maintainability. The infrastructure consists of the following modules:

- **ALB (Application Load Balancer)**
- **ECS Cluster**
- **IAM (Identity and Access Management)**
- **Lambda Functions**
- **RDS (Relational Database Service)**
- **VPC (Virtual Private Cloud)**

Each module is responsible for provisioning its respective AWS resources.

## Prerequisites

Before running this Terraform project, ensure that you have the following:

- Terraform v0.12.x or higher installed
- AWS CLI configured with appropriate credentials
- Adequate permissions to create the resources defined in the Terraform configurations
- 

## Project Structure

- `main.tf` - Root module that calls other modules to provision AWS resources.
- `modules/` - Contains submodules, each of which provisions a part of the infrastructure:
  - `alb/` - Configures the Application Load Balancer.
  - `ecs-cluster/` - Sets up the ECS Cluster and associated services.
  - `iam/` - Manages IAM roles and policies for the ECS tasks and Lambda functions.
  - `lambda/` - Contains Lambda function definitions and their triggers.
  - `rds/` - Provisions RDS instances and related configurations.
  - `vpc/` - Sets up the VPC, including subnets, route tables, and internet gateways.
- `outputs.tf` - Defines outputs after the Terraform apply is complete.
- `README.md` - Provides information about the project and setup instructions.

## Usage

To use this project, follow these steps:

1. Initialize Terraform:

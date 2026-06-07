# Flask Frontend & Express Backend Deployment Assignment

## Overview

This project demonstrates deploying a simple application consisting of:

* **Frontend:** Flask application
* **Backend:** Express.js API

The frontend provides a form that accepts:

* Name
* Email
* Message

Upon submission, the data is sent to the Express backend API and a success message is displayed to the user.

The assignment was completed in three parts:

1. Local Kubernetes deployment using Minikube
2. Deployment on EC2 using Terraform
3. Containerized deployment using Docker, ECR, ECS Fargate, and Application Load Balancer (ALB)

---

# Application Architecture

```text
User
  |
  v
Flask Frontend
  |
  v
Express Backend
```

The backend receives and processes form submissions.

---

# Part 1: Deploy Flask Frontend and Express Backend on Kubernetes (Minikube)

## Objective

Deploy both applications on a local Kubernetes cluster using Minikube.

## Components

### Frontend

* Flask application
* Runs on Port 5000

### Backend

* Express.js application
* Runs on Port 3000

### Kubernetes Resources

#### Backend

* Deployment
* Service

#### Frontend

* Deployment
* Service

## Steps Performed

### Start Minikube

```bash
minikube start
```

### Build Docker Images

```bash
docker build -t flask-frontend ./Frontend

docker build -t express-backend ./Backend
```

### Apply Kubernetes Resources

```bash
kubectl apply -f k8s/backend/

kubectl apply -f k8s/frontend/
```

### Verify Deployments

```bash
kubectl get pods

kubectl get svc
```

### Access Application

```bash
minikube service frontend-service
```

## Outcome

Both applications were successfully deployed and accessible through Minikube.

---

# Part 2: Deploy Flask and Express on Separate EC2 Instances Using Terraform

## Objective

Deploy frontend and backend on separate EC2 instances provisioned using Terraform.

## Infrastructure

### Frontend EC2

* Ubuntu EC2 Instance
* Flask Application
* Port 5000

### Backend EC2

* Ubuntu EC2 Instance
* Express Application
* Port 3000

### Terraform Resources

* EC2 Instances
* Security Groups
* User Data Scripts
* Outputs

## Terraform Structure

```text
terraform/
├── provider.tf
├── variables.tf
├── outputs.tf
├── main.tf
├── terraform.tfvars
├── frontend-user.sh
└── backend-user.sh
```

## Deployment Steps

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Review Plan

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

### Verify

```bash
terraform output
```

Outputs included:

* Frontend Public IP
* Backend Public IP

## Outcome

The Flask frontend and Express backend were successfully deployed on separate EC2 instances and communicated over public endpoints.

---

# Part 3: Deploy Flask and Express Using Docker, ECR, ECS Fargate and ALB

## Objective

Deploy containerized applications using AWS managed container services.

## Architecture

```text
Internet
    |
    v
Application Load Balancer
    |
    +------------------+
    |                  |
    v                  v
Frontend Service   Backend Service
(ECS Fargate)      (ECS Fargate)
    |                  |
    +--------+---------+
             |
             v
         ECS Cluster

ECR
├── flask-frontend
└── express-backend
```

---

## Dockerization

### Frontend

Dockerized using Python 3.11 image.

### Backend

Dockerized using Node.js 20 image.

---

## AWS Services Used

### Amazon ECR

Created repositories:

* flask-frontend
* express-backend

### Amazon ECS

Created:

* ECS Cluster
* ECS Task Definitions
* ECS Services

### AWS Fargate

Used as serverless compute engine for containers.

### Application Load Balancer

Configured to route traffic to ECS services.

### CloudWatch Logs

Used for container logging and monitoring.

### Default VPC

Used existing AWS Default VPC and Subnets.

---

## Terraform Structure

```text
terraform/
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── data.tf
├── ecr.tf
├── iam.tf
├── security-groups.tf
├── alb.tf
└── ecs.tf
```

---

## Deployment Steps

### Initialize Terraform

```bash
terraform init
```

### Create Infrastructure

```bash
terraform apply
```

Resources created:

* ECR Repositories
* ECS Cluster
* Security Groups
* Target Groups
* Application Load Balancer

---

## Build Docker Images

Frontend

```bash
docker buildx build \
--platform linux/amd64 \
-t flask-frontend ./Frontend --load
```

Backend

```bash
docker buildx build \
--platform linux/amd64 \
-t express-backend ./Backend --load
```

---

## Push Images to ECR

Authenticate:

```bash
aws ecr get-login-password \
--region ap-south-1 | docker login \
--username AWS \
--password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

Push images:

```bash
docker push <frontend-ecr-url>:latest

docker push <backend-ecr-url>:latest
```

---

## Deploy ECS Services

```bash
terraform apply
```

ECS Services were created and attached to ALB Target Groups.

---

## Application Access

Terraform Output:

```bash
terraform output
```

Example:

```text
http://assignment-alb-xxxxxxxx.ap-south-1.elb.amazonaws.com
```

---

## Logging

Container logs are available in CloudWatch.

Frontend:

```text
/ecs/flask-frontend
```

Backend:

```text
/ecs/express-backend
```

View logs:

```bash
aws logs tail /ecs/express-backend --follow
```

---

# Cleanup

Destroy all Terraform-managed resources:

```bash
terraform destroy
```

Resources removed:

* ECS Services
* ECS Tasks
* ECS Cluster
* ALB
* Target Groups
* Security Groups
* CloudWatch Log Groups
* ECR Repositories

Resources retained:

* S3 Backend State Bucket
* Default VPC
* Default Subnets
* Existing IAM Roles

---

# Technologies Used

## Programming Languages

* Python
* JavaScript

## Frameworks

* Flask
* Express.js

## Containerization

* Docker

## Orchestration

* Kubernetes
* ECS Fargate

## Infrastructure as Code

* Terraform

## AWS Services

* EC2
* ECR
* ECS
* Fargate
* ALB
* CloudWatch
* IAM
* VPC

---

# Outcome

Successfully implemented three deployment approaches:

1. Kubernetes deployment using Minikube.
2. Infrastructure provisioning and deployment on EC2 using Terraform.
3. Production-style container deployment using Docker, ECR, ECS Fargate, and Application Load Balancer managed through Terraform.

This demonstrates application deployment across local Kubernetes environments, virtual machine infrastructure, and modern cloud-native container platforms.

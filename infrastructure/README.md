# Infrastructure

## 1. Project Introduction

### Purpose
This project serves as an educational demonstration of DevOps practices and Infrastructure as Code (IaC) principles using Terraform. It was created to help university students understand the real-world application of DevOps methodologies and provide a hands-on example of how infrastructure is provisioned in modern tech environments.

### Infrastructure Created
This Terraform code provisions a complete application environment including:
- A Virtual Private Cloud (VPC) with public and private subnets
- Application load balancer for traffic distribution
- Auto-scaling groups to handle varying load
- Containerized web application with a simple API
- Database instance for persistent storage
- Monitoring and logging components

The infrastructure demonstrates a typical three-tier architecture (web, application, and database layers) that would support a production-ready application.

### DevOps Principles Demonstrated
This project embodies several core DevOps principles:
- **Infrastructure as Code**: Entire environment defined in code (Terraform)
- **Automation**: Repeatable, consistent environment creation without manual steps
- **Version Control**: Infrastructure changes tracked alongside application code
- **Continuous Integration**: Validation of infrastructure changes through automated tests
- **Configuration Management**: Environment configurations stored as code
- **Immutable Infrastructure**: Resources rebuilt rather than modified in-place

## 2. DevOps Overview

### What is DevOps?
DevOps is a set of practices that combines software development (Dev) and IT operations (Ops) to shorten the systems development life cycle while delivering features, fixes, and updates frequently, reliably, and at scale. DevOps aims to break down traditional silos between development and operations teams, creating a collaborative culture with shared responsibility for delivering working software.

At its core, DevOps is about:
- Continuous integration and delivery of software
- Automation of manual tasks
- Infrastructure management through code
- Monitoring and observability
- Collaboration and communication across teams

### Key DevOps Practices in This Project
This demo implements several fundamental DevOps practices:

1. **Infrastructure as Code (IaC)**: All infrastructure resources are defined in Terraform configuration files rather than being manually created.

2. **CI/CD Pipeline Integration**: The project demonstrates how infrastructure changes can be validated, tested, and deployed through an automated pipeline.

3. **Self-Service Infrastructure**: Developers can provision resources without requiring specialized operations knowledge.

4. **Immutable Infrastructure**: Resources are never modified in-place; instead, new resources are created and old ones destroyed, ensuring consistency and reducing configuration drift.

5. **Automated Testing**: Infrastructure validation tests ensure that the deployed environment meets expectations.

### Importance of Infrastructure as Code in DevOps

Infrastructure as Code (IaC) is a cornerstone of DevOps for several reasons:

1. **Consistency**: IaC eliminates configuration drift by ensuring environments are built identically every time.

2. **Speed**: Provisioning entire environments can be reduced from days or weeks to minutes or hours.

3. **Scalability**: Resources can be quickly scaled up or down as needed through code changes.

4. **Documentation**: The code itself serves as documentation for what infrastructure exists and how it's configured.

5. **Version Control**: Infrastructure changes can be tracked, reviewed, and rolled back just like application code.

6. **Collaboration**: Infrastructure definitions can be shared, reused, and improved across teams.

7. **Risk Reduction**: Testing infrastructure changes before applying them to production reduces the risk of outages.

8. **Compliance and Governance**: Policy as code can enforce security and compliance requirements automatically.

By implementing IaC with Terraform in this project, we demonstrate how modern DevOps teams manage cloud infrastructure with the same rigor and practices traditionally applied to application code.

# 🛠 How to Run This (Infrastructure)

This guide walks you through deploying infrastructure for the **HCMUS DevOps Seminar** demo project using **Terraform** and **AWS**.

---

## ✅ 1. Create a New AWS Credential

You need an AWS access key to deploy infrastructure. Here's how to create one:

1. Go to the AWS Console → **IAM** → **Users** → your user → **Security credentials**
2. Create a new **Access Key**
3. Configure it on your local machine:

```bash
aws configure --profile hcmus_seminar
```

Replace hcmus_seminar with any profile name you like. You’ll be prompted to enter your Access Key ID, Secret Access Key, default region, and output format.

## 📄 2. Create a dev.tfvars File
In the infrastructure/ folder, create a file named dev.tfvars with the following content:

```hcl
aws_profile = "hcmus_seminar"
vpc_name = "hcmus-seminar"
container_port = 3000
vpc_cidr_block = "10.0.0.0/16"
region = "ap-southeast-1"

app_service_subnets = [
  {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-southeast-1a"
  },
  {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-southeast-1b"
  }
]

app_elb_subnets = [
  {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "ap-southeast-1a"
  },
  {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "ap-southeast-1b"
  }
]

service_name = "hcmus-seminar"
image_url = image_url"

env_variables = [
  {
    name  = "DATABASE_URL"
    value = ""
  }
]

memory = "512"
cpu = "256"
enable_load_balancer = true
enable_service_discovery = false
desired_count = 1
launch_type = "FARGATE"
platform_version = "1.4.0"
ecs_role_name = "ecsTaskExecutionRole"
min_capacity = 1
max_capacity = 1
memory_limit_scaling = 70
cpu_limit_scaling = 70
service_discovery_dns = "hcmus-seminar.local"
```

🛡️ Note: The values above use mock data or public-safe values. Be cautious not to commit sensitive information like secrets or credentials.

## 🚀 3. Deploy with Terraform
Run the following commands from the infrastructure/ directory:

```bash
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

📌 Notes
- You must have Terraform installed: https://www.terraform.io/downloads

- Make sure your AWS profile is configured correctly before running the commands

- Infrastructure created includes: VPC, ECS Cluster & Service, Load Balancer, IAM roles, and networking
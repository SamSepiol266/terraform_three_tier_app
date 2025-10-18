# 🚀 Terraform AWS 3-Tier Web Application

This project provisions a **three-tier web application architecture** on **AWS** using **Terraform** — built to demonstrate production-grade Infrastructure-as-Code skills.

It includes a **public-facing load balancer**, **private EC2 application servers**, and a **managed RDS PostgreSQL database**, all deployed inside a secure, custom **VPC**.

---

## 🏗️ Architecture Overview

**Components:**
- **VPC** with public and private subnets across multiple Availability Zones
- **Application Load Balancer (ALB)** routing traffic to private EC2 instances
- **EC2 Auto Scaling Group** hosting a simple web application
- **RDS PostgreSQL** instance in private subnets for persistent storage
- **Security Groups** with least-privilege inbound/outbound rules
- **IAM Roles & Policies** for secure instance access
- **User-Defined Variables** for project naming, region, and configuration

**Region:** `us-west-1`

**Design Principles:**
- Separation of concerns (network, compute, database)
- Reusable Terraform modules
- Declarative, version-controlled IaC
- Scalable and secure by default

---

## ⚙️ Prerequisites

Before deploying, ensure you have:
- An AWS account with appropriate permissions  
- Terraform >= 1.0 installed  
- AWS CLI configured with valid credentials  

---

## 🚀 Deployment Instructions

1. **Initialize the project**
       terraform init
   
2. **Preview the plan
       terraform plan
   
3. **Apply the Infrastructure
       terraform apply
   
4. Destory resources (when finished)
       terraform destroy

   

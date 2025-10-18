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

   
-----------------------------------------------------------------------------------------------------------

🚀 Thread: Why I Built My 3-Tier AWS Web App with Terraform

Over the past few months, I realized something:
       Having certifications isn’t enough.
       I wanted proof that I could design, automate, and deploy real cloud infrastructure from end to end.

So I built a 3-tier web application on AWS entirely with Terraform.

# Why this project?

Because this is the architecture real companies actually run:

       Load Balancer for routing

       Application layer on EC2

       Managed PostgreSQL in RDS
       
All provisioned automatically through Infrastructure-as-Code.

No manual setup. No clicking through the AWS console.

# What I wanted to prove:
       I can architect multi-tier systems from scratch
       I understand Terraform module structure & variables
       I can integrate networking, security groups, and compute resources cohesively
       I can deploy reliably to any region

# What I learned along the way:

       The importance of clean module design — reusable, parameterized, and DRY.

       How small VPC misconfigurations can break entire environments.

       That IaC is as much about thinking clearly as it is about writing code.

# Why it matters:
       This project bridges the gap between certified and experienced.
       It’s not just something I studied — it’s something I built, debugged, and shipped.
       It’s now part of my portfolio, fully public on GitHub and featured on my LinkedIn.

BearsPortal 🐾

A simple student course registration web app built with HTML, CSS, and vanilla JavaScript.

 Files

- `login.html` — Login page. Enter any Student ID and password to access the portal.
- `schedule.html` — Main portal. Shows your enrolled courses and the full course catalog.
- `styles.css` — Shared styles used by both pages.

Features

- Login with Student ID and password
- Browse course catalog with search and department filter
- Add courses to your schedule (up to 18 credits)
- Drop courses from your schedule
- Time conflict detection — alerts you if two courses overlap and blocks the add
- Confirm registration page to review courses before finalizing
- Brown and yellow Bears theme with 🐾 paw logo

How to Run

No server or installation needed. Just open `login.html` in any web browser.

All three files must be in the same folder for the CSS and page navigation to work.

Validation Rules

- Cannot exceed 18 total credits
- Cannot add a course with no available seats
- Cannot add a course that overlaps in time with an already enrolled course

Tech Stack

- HTML
- CSS
- JavaScript (no frameworks or libraries)
- `sessionStorage` used to pass login state between pages

  Backend
  CSC Course Registration Demo 🐾  
  Infrastructure as Code (IaC) + AWS Deployment

This repository contains a **cloud-based course registration demo system** deployed using **Terraform on AWS**. The project demonstrates how to provision and manage infrastructure using Infrastructure as Code (IaC) while hosting a simple web application in a scalable and highly available environment.

The system architecture consists of:
- An **Application Load Balancer (ALB)** as the public entry point  
- **Two EC2 instances** running in private subnets  
- A **Virtual Private Cloud (VPC)** with networking and security configurations  

At a high level, user requests follow this flow:

This setup ensures that incoming traffic is distributed across multiple backend servers, improving availability and reliability.

---

Infrastructure Overview

Terraform resources in this repository are organized into structured files to separate concerns such as networking, security, compute, and load balancing.

The *foundation layer* defines Terraform providers, global variables, and naming conventions using:
- `c1 version.tf`
- `c2.generic variables.tf`
- `c3-local-values.tf`

The *networking layer* creates the AWS environment:
- `c4-01-vpc-variables.tf` defines CIDR blocks, availability zones, and subnet configuration  
- `c4-02-vpc-module.tf` provisions the VPC, public and private subnets, and routing  

The *security layer* controls access:
- `c5-05-securitygroup-loadbalancersg.tf` allows HTTP traffic from the internet to the ALB  
- `c5-04-securitygroup-privatesg.tf` restricts EC2 access to internal VPC traffic  

The *compute layer* provisions the backend servers:
- `c6-01-datasource-ami.tf` selects the Amazon Linux 2 AMI  
- `c7-01-ec2instance-variables.tf` defines instance type and key pair  
- `c7-04-ec2instance-private.tf` launches two EC2 instances in private subnets  
- `app1-install.sh` runs automatically at launch to configure the instances  

The *load balancing layer* handles traffic distribution:
- `c11-02-ALB-application-loadbalancer.tf` defines the ALB, listener, and target group  
- `c11-03-ALB-application-loadbalancer.tf` outputs the ALB DNS name  

Files such as `c10-*` (Classic ELB) and `c13-*` (RDS) are not required for this demo but can be used for future extensions.

---

## Prerequisites

Before deploying the infrastructure, ensure the following tools and configurations are available:

- Terraform installed  
- AWS CLI installed  
- AWS credentials configured using:
  ```bash
  aws configure

Terraform init

Tearrform validate

Terraform plan

Terraform apply



After deployment, confirm that the system is functioning correctly:

Terraform configuration validates successfully
The ALB target group shows healthy instances
The ALB DNS endpoint is reachable
Repeated page refreshes route traffic across both EC2 instances

These checks confirm that load balancing and infrastructure configuration are working as expected.

Customization

The infrastructure can be customized depending on requirements:

Modify EC2 instance type in c7-01-ec2instance-variables.tf
Adjust network CIDR ranges in c4-01-vpc-variables.tf
Update security rules in c5-* files
Change ALB health check path in c11-02-ALB-application-loadbalancer.tf

terraform destroy

Demo Implementation

To prepare the system for presentation:

Deploy the same application on both EC2 instances
Ensure a health endpoint (e.g., /health) returns HTTP 200
Implement a clickable course registration interface
Align ALB health checks with application routes
Display instance ID or hostname in the UI to demonstrate load balancing
Presentation Workflow

During a live demo:

Open the ALB DNS URL
Navigate through the course registration interface
Select and register a course
Display the confirmation page
Open the AWS Console to show:
ALB status
Target group health
Traffic distribution across instances

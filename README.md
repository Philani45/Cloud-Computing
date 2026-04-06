# Infrastructure as Code (IaC) Guide

This document explains the Terraform infrastructure in this repository for the **CSC Course Registration Demo** architecture:

- Application Load Balancer (public)
- Two EC2 application instances (private subnets)
- VPC networking, subnets, and security groups

## 1) What this IaC deploys

High-level flow:

`User -> ALB (HTTP:80) -> Target Group -> 2 Private EC2 instances`

Terraform resources are organized by numbered files.

## 2) Required IaC files and purpose

### Foundation
- `c1 version.tf`
  - Terraform required providers and AWS provider region.
- `c2.generic variables.tf`
  - Global environment/business variables.
- `c3-local-values.tf`
  - Local naming and common tags.

### Networking (VPC/Subnets)
- `c4-01-vpc-variables.tf`
  - VPC CIDR, AZs, public/private/database subnets, NAT flags.
- `c4-02-vpc-module.tf`
  - VPC module implementation and subnet/NAT configuration.

### Security
- `c5-05-securitygroup-loadbalancersg.tf`
  - ALB security group (HTTP from internet).
- `c5-04-securitygroup-privatesg.tf`
  - Private EC2 security group (HTTP/SSH from VPC CIDR).

### Compute
- `c6-01-datasource-ami.tf`
  - AMI data source (Amazon Linux 2).
- `c7-01-ec2instance-variables.tf`
  - EC2 instance type and key pair variables.
- `c7-04-ec2instance-private.tf`
  - Two private EC2 instances with app bootstrap via `user_data`.
- `app1-install.sh`
  - Instance bootstrap script executed at launch.

### Load Balancing
- `c11-02-ALB-application-loadbalancer.tf`
  - ALB module, listener, target group, and EC2 target attachments.
- `c11-03-ALB-application-loadbalancer.tf`
  - ALB outputs (including DNS name).

## 3) Files not required for this ALB demo

- `c10-*` files are for **Classic ELB** and are not required when using ALB.
- `c13-*` files are for RDS and optional for a DB-backed extension.
- Bastion-related files are optional for administration workflows.

## 4) Prerequisites

- Terraform installed
- AWS CLI installed
- Valid AWS credentials configured (`aws configure` or environment variables)
- Existing EC2 key pair name that matches `instance_keypair` default or tfvars override

## 5) How to deploy

From repository root:

```bash
terraform init
terraform plan
terraform apply
```

When apply is complete, Terraform outputs the ALB DNS name (`dns_name`).
Open that URL in a browser to verify traffic routing.

## 6) Common customizations

- Change instance size in `c7-01-ec2instance-variables.tf`.
- Change CIDR/subnet layout in `c4-01-vpc-variables.tf`.
- Tighten ingress rules in SG files under `c5-*`.
- Update health check path in `c11-02-ALB-application-loadbalancer.tf` to match your app route.

## 7) Validation checklist

- `terraform validate` passes.
- ALB target group shows healthy targets.
- ALB DNS endpoint is reachable.
- Repeated requests hit both backends (if app displays server identity).

## 8) Cleanup

To avoid ongoing AWS charges:

```bash
terraform destroy
```


# Nexus Project — AWS Infrastructure with Terraform

This repository contains the Infrastructure as Code (IaC) configuration used to provision and manage AWS resources for the Nexus project using Terraform. The codebase is organized into two separate layers—a **bootstrap** layer for remote state storage and an **application** layer (`ec2-app`) for compute and networking resources.

---

## Repository Structure

nexus-project/
├── .gitignore
├── README.md
├── bootstrap/                  # Remote state S3 bucket configuration
│   └── main.tf
└── ec2-app/                    # EC2 instance and security group stack
    ├── backend.tf
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    └── variables.tf
```

---

## Architecture & Implementation Overview

Using Terraform, I provisioned a `t3.micro` EC2 instance inside the default VPC in `us-east-1` then i paired with a custom security group. To keep the configuration clean and modular, the application layer is split across dedicated files (`providers.tf`, `variables.tf`, `main.tf`, `outputs.tf`, and `backend.tf`), restricts security group traffic to outbound-only egress rules by default, and enforces IMDSv2 (`http_tokens = "required"`) on the EC2 instance.

### Key Architectural Decision: Isolated S3 Remote State Bootstrap

To avoid storing Terraform state locally and to solve the chicken and egg problem where Terraform cannot store its state in an S3 bucket that does not yet exist—I separated the S3 state bucket (`nexus-tfstate-s3bucket`) into an isolated `bootstrap/` configuration before deploying `ec2-app/`.

During setup, an AWS Organizations Service Control Policy initially blocked `s3:CreateBucket` in the target member account. After updating the SCP to permit bucket creation for the deployment IAM user, the bucket was provisioned with server-side encryption and versioning enabled, and `ec2-app/backend.tf` was configured to use it with native S3 state locking (`use_lockfile = true`).

---

## Prerequisites

* [Terraform](https://developer.hashicorp.com/terraform/downloads) (`>= 1.10.0` for native S3 `use_lockfile` state locking)
* [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials (`aws configure`)
* IAM permissions to manage S3 buckets, EC2 instances, and VPC Security Groups in `us-east-1`

---

variable "aws_region" {
  type        = string
  description = "AWS region for the EC2 instance"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "instance_name" {
  type        = string
  description = "Name tag for the EC2 instance"
  default     = "week-deliverable-ec2"
}

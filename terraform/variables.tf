# AWS Region
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

# Docker image URL for ECS app
variable "image_url" {
  description = "Full ECR Docker image URL for ECS Fargate service"
  type        = string
}

# ECS service security group (e.g., ALB SG)
variable "security_group_id" {
  description = "Security group ID to attach to ECS service"
  type        = string
}

# RDS Credentials
variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "devopsdb"
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "The endpoint of the RDS database"
  type        = string
}

variable "db_port" {
  description = "Port for the RDS database"
  type        = number
  default     = 3306
}

# Environment name (e.g., Dev, Prod)
variable "env_name" {
  description = "Environment name (e.g., Dev, Prod)"
  type        = string
}
# ECR Repository Name
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

# IAM Role for CI/CD (GitHub Actions, etc.)
variable "iam_role" {
  description = "IAM role to assume for CI/CD pipeline (GitHub Actions)"
  type        = string
}

# Optional: CloudWatch alert thresholds (for cloudwatch module)
variable "cpu_threshold" {
  description = "CloudWatch alarm threshold for ECS CPU usage"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "CloudWatch alarm threshold for ECS memory usage"
  type        = number
  default     = 75
}

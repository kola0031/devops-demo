# AWS Region
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.aws_region))
    error_message = "AWS region must be valid (e.g., us-east-1, eu-west-1)."
  }
}

# AWS Credentials
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

# Docker image URL for ECS app
variable "image_url" {
  description = "Full ECR Docker image URL for ECS Fargate service"
  type        = string

  validation {
    condition     = can(regex("^\\d{12}\\.dkr\\.ecr\\.[a-z]{2}-[a-z]+-[0-9]{1}\\.amazonaws\\.com/.+", var.image_url))
    error_message = "Image URL must be a valid ECR URL."
  }
}

# ECS service security group
variable "security_group_id" {
  description = "Security group ID to attach to ECS service"
  type        = string
  default     = ""
}

# RDS Configuration
variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "devopsdb"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_]{0,63}$", var.db_name))
    error_message = "Database name must start with a letter and contain only alphanumeric characters and underscores."
  }
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"

  validation {
    condition     = length(var.db_username) >= 1 && length(var.db_username) <= 16
    error_message = "Database username must be between 1 and 16 characters."
  }
}

variable "db_password" {
  description = "Password for the RDS database. Must contain at least 8 characters and include uppercase, lowercase, numbers, and special characters."
  type        = string
  sensitive   = true
  default     = null

  validation {
    condition = var.db_password == null || (
      length(var.db_password) >= 8 &&
      can(regex("[A-Z]", var.db_password)) &&
      can(regex("[a-z]", var.db_password)) &&
      can(regex("[0-9]", var.db_password)) &&
      can(regex("[^A-Za-z0-9]", var.db_password))
    )
    error_message = "Password must be at least 8 characters long and contain uppercase, lowercase, numbers, and special characters."
  }
}

variable "db_host" {
  description = "The endpoint of the RDS database"
  type        = string
}

variable "db_port" {
  description = "Port for the RDS database"
  type        = number
  default     = 3306

  validation {
    condition     = var.db_port > 0 && var.db_port < 65536
    error_message = "Database port must be between 1 and 65535."
  }
}

# Environment name
variable "environment" {
  description = "Environment name (e.g., Dev, Staging, Prod)"
  type        = string
  default     = "Dev"

  validation {
    condition     = contains(["Dev", "Staging", "Prod"], var.environment)
    error_message = "Environment must be either Dev, Staging, or Prod."
  }
}

# ECR Repository Configuration
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-_]{0,254}$", var.repository_name))
    error_message = "Repository name must start with a letter and contain only lowercase letters, numbers, hyphens, and underscores."
  }
}

# IAM Role for CI/CD (GitHub Actions, etc.)
variable "iam_role" {
  description = "IAM role to assume for CI/CD pipeline (GitHub Actions)"
  type        = string
}

# CloudWatch Monitoring Configuration
variable "cpu_threshold" {
  description = "CloudWatch alarm threshold for ECS CPU usage (percentage)"
  type        = number
  default     = 80

  validation {
    condition     = var.cpu_threshold > 0 && var.cpu_threshold <= 100
    error_message = "CPU threshold must be between 1 and 100 percent."
  }
}

variable "memory_threshold" {
  description = "CloudWatch alarm threshold for ECS memory usage (percentage)"
  type        = number
  default     = 75

  validation {
    condition     = var.memory_threshold > 0 && var.memory_threshold <= 100
    error_message = "Memory threshold must be between 1 and 100 percent."
  }
}

variable "db_password_arn" {
  description = "ARN of the secret containing the database password"
  type        = string
}


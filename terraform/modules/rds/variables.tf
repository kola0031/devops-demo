variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS deployment"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name (Dev, Staging, Prod)"
  type        = string
  validation {
    condition     = contains(["Dev", "Staging", "Prod"], var.environment)
    error_message = "Environment must be either Dev, Staging, or Prod."
  }
}

variable "ecs_security_group_id" {
  description = "Security group ID of the ECS service"
  type        = string
}

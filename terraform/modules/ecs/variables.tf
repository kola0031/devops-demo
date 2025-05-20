variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "image_url" {
  description = "URL of the container image"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "devops-web"
}

variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password_arn" {
  description = "ARN of the secret containing the database password"
  type        = string
}

variable "env_name" {
  description = "Environment name"
  type        = string
  default     = "Dev"
}

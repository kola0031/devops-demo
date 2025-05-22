variable "vpc_id" {
  description = "VPC ID where the ECS cluster will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the ECS tasks will be launched"
  type        = list(string)
}

variable "image_url" {
  description = "URL of the container image to use"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the ECS tasks"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
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
  description = "ARN of the database password secret"
  type        = string
}

variable "env_name" {
  description = "Environment name"
  type        = string
  default     = "Production"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group for the ECS service"
  type        = string
}

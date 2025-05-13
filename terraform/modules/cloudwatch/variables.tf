variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}

variable "cpu_threshold" {
  description = "Threshold for high CPU usage"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Threshold for high memory usage"
  type        = number
  default     = 75
}

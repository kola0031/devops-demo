output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.db_endpoint
}

output "db_name" {
  description = "The name of the database"
  value       = module.rds.db_name
}

output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = module.rds.db_instance_id
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = module.ecs.service_name
} 
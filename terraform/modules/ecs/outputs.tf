output "ecs_cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "ecs_service_name" {
  value = aws_ecs_service.php_service.name
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.php_service.name
}

output "security_group_id" {
  description = "ID of the ECS tasks security group"
  value       = aws_security_group.ecs_tasks.id
}
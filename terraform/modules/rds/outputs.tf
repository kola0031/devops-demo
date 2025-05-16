output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.mysql.endpoint
}

output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.mysql.db_name
}

output "security_group_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.rds_sg.id
}

output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.mysql.id
}

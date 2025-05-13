# AWS region for deployment
aws_region = "us-east-1"

# Docker image URL from your ECR
image_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/devops-demo:1.1"

# Security group ID for ECS service (can be the ALB SG)
security_group_id = "sg-xxxxxxxxxxxxxxxxx"

# RDS database credentials
db_name     = "devopsdb"
db_username = "admin"
db_password = "SuperSecurePassword123"  # Consider using Secrets Manager in prod
db_host     = "rds-endpoint.amazonaws.com"  # Replace with the actual RDS endpoint
db_port     = 3306

# ECR repository details
repository_name = "devops-demo"

# IAM role for GitHub Actions or CI/CD to assume (if using OIDC)
iam_role = "arn:aws:iam::123456789012:role/GitHubActionRole"

# Environment name
env_name = "Dev"
# AWS Region for deployment
aws_region = "us-east-1"

# Environment name (Dev/Staging/Prod)
env_name = "Dev"

# Docker image URL from ECR (update with your account ID and image version)
image_url = "929449381556.dkr.ecr.us-east-1.amazonaws.com/devops-demo:latest"

# RDS Configuration
db_name     = "devopsdb"
db_username = "admin"
# Password will be provided via environment variable TF_VAR_db_password
db_password = ""
db_host     = "devopsdb.cd6eq8000qil.us-east-1.rds.amazonaws.com" # Replace with the actual RDS endpoint
db_port     = 3306

# ECR Repository Configuration
repository_name = "devops-demo"

# CloudWatch Monitoring Thresholds (percentage)
cpu_threshold    = 80
memory_threshold = 75

# IAM role for GitHub Actions or CI/CD to assume (if using OIDC)
iam_role = "arn:aws:iam::929449381556:user/kops01"
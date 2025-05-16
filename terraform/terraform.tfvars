# AWS Region for deployment
aws_region = "us-east-1"

# Environment name (Dev/Staging/Prod)
env_name = "Dev"

# Docker image URL from ECR (update with your account ID and image version)
image_url = "929449381556.dkr.ecr.us-east-1.amazonaws.com/devops-demo:latest"

# Security group ID for ECS service
# TODO: Update with your security group ID after creating it
security_group_id = ""

# RDS Configuration
db_name     = "devopsdb"
db_username = "admin"
# DO NOT store the password here. Use AWS Secrets Manager or pass it as an environment variable
# Example: export TF_VAR_db_password="your-secure-password"
db_password = ""
db_host     = "devopsdb.cd6eq8000qil.us-east-1.rds.amazonaws.com"  # Replace with the actual RDS endpoint
db_port     = 3306

# ECR Repository Configuration
repository_name = "devops-demo"

# CloudWatch Monitoring Thresholds (percentage)
cpu_threshold    = 80
memory_threshold = 75

# IAM role for GitHub Actions or CI/CD to assume (if using OIDC)
iam_role = "arn:aws:iam::929449381556:user/kops01"

module "rds" {
  source = "./modules/rds"
  
  vpc_id               = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  environment         = var.env_name
  ecs_security_group_id = module.ecs.security_group_id
}
# --- General Settings ---
aws_region = "us-east-1"

# --- VPC ---
vpc_cidr_block = "10.0.0.0/16"

# --- ECS ---
image_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/devops-demo:1.1"
security_group_id = "sg-xxxxxxxxxxxxxxxxx"  # ALB or ECS SG

# --- RDS ---
db_username = "admin"
db_password = "SuperSecurePassword123!"  # Ideally use environment variable or Secrets Manager in production
db_name     = "devopsdb"

# --- Optional: if you're using dynamic or custom inputs ---
# public_subnet_ids  = ["subnet-abc123", "subnet-def456"]
# private_subnet_ids = ["subnet-xyz789", "subnet-ghi012"]

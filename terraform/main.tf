terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "devops-demo/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.env_name
      Project     = "DevOps-Demo"
      ManagedBy   = "Terraform"
    }
  }
}

# Network Infrastructure
module "vpc" {
  source = "./modules/vpc"

  environment = var.env_name
}

# Container Infrastructure
module "ecr" {
  source = "./modules/ecr"

  repository_name = var.repository_name
  environment    = var.env_name
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_subnet_ids
  image_url         = var.image_url
  security_group_id = var.security_group_id
  environment       = var.env_name
}

# Database Infrastructure
module "rds" {
  source = "./modules/rds"

  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  environment = var.env_name
}

# Load Balancer
module "alb" {
  source = "./modules/alb"

  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  environment = var.env_name
}

# Monitoring
module "cloudwatch" {
  source = "./modules/cloudwatch"

  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  cpu_threshold    = var.cpu_threshold
  memory_threshold = var.memory_threshold
  environment      = var.env_name
}

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.51.0"
    }
  }

  backend "s3" {
    bucket  = "devops-demo-terraform-state-929449381556"
    key     = "devops-demo/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  default_tags {
    tags = {
      Project   = "DevOps-Demo"
      ManagedBy = "Terraform"
    }
  }
}

# Network Infrastructure
module "vpc" {
  source = "./modules/vpc"
}

# Container Infrastructure
module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.repository_name
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  image_url             = var.image_url
  security_group_id     = module.vpc.ecs_security_group_id
  aws_region            = var.aws_region
  db_host               = var.db_host
  db_name               = var.db_name
  db_username           = var.db_username
  db_password_arn       = var.db_password_arn
  environment           = var.environment
  container_name        = "devops-web"
}

# Database Infrastructure
module "rds" {
  source = "./modules/rds"

  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  environment           = var.environment
  ecs_security_group_id = module.vpc.ecs_security_group_id
}

# Load Balancer
module "alb" {
  source = "./modules/alb"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
}

# Monitoring
module "cloudwatch" {
  source = "./modules/cloudwatch"

  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  cpu_threshold    = var.cpu_threshold
  memory_threshold = var.memory_threshold
}


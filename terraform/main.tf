provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source            = "./modules/ecs"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_subnet_ids
  image_url         = var.image_url # Replace with the actual image URL
  security_group_id = var.security_group_id # Replace with the actual security group ID
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
  db_password = "your-db-password" # Replace with the actual database password
}

module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
}

module "ecr" {
  source          = "./modules/ecr"
  iam_role        = var.iam_role          # Replace with the actual IAM role
  repository_name = var.repository_name   # Replace with the actual repository name
}

module "cloudwatch" {
  source           = "./modules/cloudwatch"
  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
}

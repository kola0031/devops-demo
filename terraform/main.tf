provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}

module "ecs" {
  source = "./ecs"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}

module "rds" {
  source = "./rds"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}

module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
}

module "ecr" {
  source = "./ecr"
}
module "cloudwatch" {
  source = "./cloudwatch"
  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
}
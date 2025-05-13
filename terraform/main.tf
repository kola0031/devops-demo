provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source      = "./modules/ecs"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
}

module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
}

module "ecr" {
  source = "./modules/ecr"
}

module "cloudwatch" {
  source           = "./modules/cloudwatch"
  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
}

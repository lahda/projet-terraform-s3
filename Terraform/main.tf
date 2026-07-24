module "ecr" {
  source              = "./modules/ecr"
  aws_region          = var.aws_region
  ecr_repository_name = var.ecr_repository_name
  environment         = var.environment
}

module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "alb" {
  source = "./modules/alb"

  aws_region                         = var.aws_region
  vpc_id                             = module.vpc.vpc_id
  alb_public_subnet_ids              = module.vpc.public_subnets_ids
  alb_security_group_id              = module.vpc.alb_security_group_id
  alb_target_group_health_check_path = "/"
}

module "ecs" {
  source = "./modules/ecs"

  environment        = var.environment
  subnet_ids         = module.vpc.public_subnets_ids
  security_group_id  = module.vpc.ecs_tasks_security_group_id
  target_group_arn   = module.alb.target_group_arn
  ecr_repository_url = module.ecr.ecr_repository_url
  container_port     = 8080
  host_port          = 8080
}

module "rds" {
  source = "./modules/rds"

  environment       = var.environment
  db_name           = var.db_name
  db_username       = var.db_username
  instance_class    = var.instance_class
  instance_count    = var.instance_count
  subnet_ids        = module.vpc.private_subnets_ids
  security_group_id = module.vpc.rds_security_group_id
}
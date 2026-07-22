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

  aws_region            = var.aws_region
  vpc_id                = module.vpc.vpc_id
  alb_public_subnet_ids = module.vpc.public_subnets_ids
  alb_security_group_id = module.vpc.alb_security_group_id
}
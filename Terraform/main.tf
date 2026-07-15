module "ecr" {
    source = "./ecr"
    aws_region            = var.aws_region
    ecr_repository_name   = var.ecr_repository_name
    environment           = var.environment  
}

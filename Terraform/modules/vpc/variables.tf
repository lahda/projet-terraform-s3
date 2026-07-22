variable "vpc_cidr" {
  description = "plage d'adresses IP pour le VPC"
  type        = string
}

variable "az_count" {
  description = "Nombre de zones de disponibilité à utiliser"
  type        = number
  default     = 2
  
}

variable "environment" {
    description = "Environnement de déploiement"
    type        = string
    default     = "dev"
  
}

variable "aws_region" {
    description = "AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "app-repo"
}

variable "aws_region" {
  description = "Région AWS où créer le repository ECR"
  type        = string
  default     = "us-east-1"
}

variable "ecr_repository_name" {
  description = "Nom du repository ECR qui contiendra l'image Docker de l'application"
  type        = string
  default     = "formation-app"
}

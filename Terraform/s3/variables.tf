variable "aws_s3_bucket" {
  description = "The name of the AWS S3 bucket."
  type        = string
  default     = "my-default-bucket"
  
}

variable "aws_region" {
    description = "The AWS region where the resources will be created."
    type        = string
    default     = "us-east-1"
  
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "app-repo"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
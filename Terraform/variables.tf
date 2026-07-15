
variable "aws_region" {
    description = "AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}

variable "bucket_name" {
    description = "Optional explicit bucket name. If empty, a name will be generated."
    type        = string
    default     = ""
}

variable "tags" {
    description = "Tags to apply to resources"
    type        = map(string)
    default = {
        ManagedBy = "terraform"
        Project   = "projet-terraform-s3"
    }
}

variable "ecr_repository_name" {
    description = "Name of the ECR repository"
    type        = string
    default     = "app-repository"
}

variable "environment" {
    description = "Environment tag for resources"
    type        = string
    default     = "dev"
}



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

variable "aws_s3_bucket_public_access_block" {
    description = "Configuration for S3 bucket public access block"
    type = object({
        block_public_acls       = bool
        block_public_policy     = bool
        ignore_public_acls      = bool
        restrict_public_buckets = bool
    })
    default = {
        block_public_acls       = true
        block_public_policy     = true
        ignore_public_acls      = true
        restrict_public_buckets = true
    }

}

variable "aws_s3_bucket_server_side_encryption_configuration" {
    description = "Configuration for S3 bucket server-side encryption"
    type = object({
        sse_algorithm = string
    })
    default = {
        sse_algorithm = "AES256"
    }
}

variable "aws_s3_bucket" {
    description = "Name of the S3 bucket"
    type        = string
    default     = "mon-bucket"
}
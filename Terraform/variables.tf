
variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "us-east-1"
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

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "admin"
}

variable "instance_class" {
  description = "Instance class for the RDS instances"
  type        = string
  default     = "db.t3.medium"
}

variable "instance_count" {
  description = "Number of instances in the RDS cluster"
  type        = number
  default     = 2
}
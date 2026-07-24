variable "environment" {
  description = "Environment tag for resources"
  type        = string
  default     = "dev"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the ECS service"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group for the ECS service"
  type        = string
}

variable "container_port" {
  description = "Port for the container"
  type        = number
  default     = 80
}

variable "host_port" {
  description = "Port for the host"
  type        = number
  default     = 80
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}
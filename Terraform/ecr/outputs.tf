/*
Outputs for ECR repositories.

This file normalizes references so it works when the aws_ecr_repository resource
is created either as a single resource or with for_each (map of resources).
*/

locals {
    # Try treating aws_ecr_repository.this as a map (for_each). If that fails,
    # fall back to treating it as a single resource instance.
    repositories = try(
        { for _, r in aws_ecr_repository.this : r.name => r },
        { for r in [aws_ecr_repository.this] : r.name => r }
    )
}

output "repository_names" {
    description = "List of ECR repository names managed by this module."
    value       = keys(local.repositories)
}

output "repository_arns" {
    description = "Map of ECR repository ARNs keyed by repository name."
    value       = { for name, r in local.repositories : name => r.arn }
}

output "repository_urls" {
    description = "Map of ECR repository URLs (registry endpoints) keyed by repository name."
    value       = { for name, r in local.repositories : name => r.repository_url }
}

output "repository_registry_ids" {
    description = "Map of ECR registry IDs for each repository keyed by repository name."
    value       = { for name, r in local.repositories : name => r.registry_id }
}

output "repository_ids" {
    description = "Map of resource IDs for each repository keyed by repository name."
    value       = { for name, r in local.repositories : name => r.id }
}

output "first_repository_name" {
    description = "Name of the first repository (useful when only one repository is managed)."
    value       = try(keys(local.repositories)[0], null)
}

output "first_repository_arn" {
    description = "ARN of the first repository (useful when only one repository is managed)."
    value       = try(values(local.repositories)[0].arn, null)
}

output "first_repository_url" {
    description = "URL of the first repository (useful when only one repository is managed)."
    value       = try(values(local.repositories)[0].repository_url, null)
}
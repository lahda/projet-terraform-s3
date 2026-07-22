output "ecr_repository_url" {
  description = "URL du repository ECR (utile pour docker push)"
  value       = aws_ecr_repository.app_repository.repository_url
}

output "ecr_repository_arn" {
  description = "ARN du repository ECR"
  value       = aws_ecr_repository.app_repository.arn
}
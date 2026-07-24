output "cluster_endpoint" {
  description = "endpoint principal du cluster aurora (lecture + ecriture)"
  value       = aws_rds_cluster.main.endpoint
}

output "cluster_reader_endpoint" {
  description = "endpoint de lecture du cluster aurora"
  value       = aws_rds_cluster.main.reader_endpoint
}

output "cluster_id" {
  description = "ID du cluster aurora"
  value       = aws_rds_cluster.main.id
}

output "cluster_instance_ids" {
  description = "IDs des instances du cluster aurora"
  value       = aws_rds_cluster_instance.main[*].id
}

output "cluster_instance_endpoints" {
  description = "Endpoints des instances du cluster aurora"
  value       = aws_rds_cluster_instance.main[*].endpoint
}

output "db_name" {
  description = "Nom de la base de données"
  value       = aws_rds_cluster.main.database_name
}

output "db_port" {
  description = "Port de la base de données"
  value       = aws_rds_cluster.main.port
}

output "credentials_secret_arn" {
  description = "ARN du secret Secrets Manager contenant les identifiants de connexion"
  value       = aws_secretsmanager_secret.db.arn
}
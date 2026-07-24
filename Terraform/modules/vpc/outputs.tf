output "vpc_id" {
  description = "ID du VPC"
  value       = aws_vpc.main.id
}

output "public_subnets_ids" {
  description = "IDs des subnets publics"
  value       = [for subnet in aws_subnet.public : subnet.id]

}

output "private_subnets_ids" {
  description = "IDs des subnets privés"
  value       = [for subnet in aws_subnet.private : subnet.id]

}

output "availability_zone_used" {
  description = "Liste des zones de disponibilités utilisées"
  value       = local.azs

}

output "alb_security_group_id" {
  description = "ID du groupe de sécurité pour l'ALB"
  value       = aws_security_group.alb.id

}

output "ecs_tasks_security_group_id" {
  description = "ID du groupe de sécurité pour les tâches ECS"
  value       = aws_security_group.ecs_tasks.id
}

output "rds_security_group_id" {
  description = "ID du groupe de sécurité pour le cluster RDS"
  value       = aws_security_group.rds.id
}
variable "vpc_id" {
    description = "ID du VPC"
    type        = string
  
}

variable "environment" {
    description = "Environnement de déploiement"
    type        = string
    default     = "dev"
  
}

variable "aws_region" {
    description = "Région AWS où créer le VPC"
    type        = string
    default     = "us-east-1"
  
}

variable "alb_security_group_id" {
    description = "ID du groupe de sécurité pour l'ALB"
    type        = string
  
}

variable "alb_target_group_health_check_path" {
    description = "Chemin de vérification de santé pour le groupe cible de l'ALB"
    type        = string
    default     = "/health"
  
}

variable "alb_target_group_health_check_timeout" {
    description = "Délai d'attente pour la vérification de santé du groupe cible de l'ALB"
    type        = number
    default     = 5
}

variable "alb_target_group_health_check_interval" {
    description = "Intervalle entre les vérifications de santé du groupe cible de l'ALB"
    type        = number
    default     = 30
  
}

variable "alb_target_group_health_check_healthy_threshold" {
    description = "Seuil de santé pour le groupe cible de l'ALB"
    type        = number
    default     = 5
  
}

variable "alb_target_group_health_check_unhealthy_threshold" {
    description = "Seuil de non-santé pour le groupe cible de l'ALB"
    type        = number
    default     = 2
  
}

variable "alb_target_group_health_check_matcher" {
    description = "Matcher pour la vérification de santé du groupe cible de l'ALB"
    type        = string
    default     = "200-299"
  
}

variable "alb_name" {
    description = "Nom de l'ALB"
    type        = string
    default     = "my-alb"
  
}

variable "alb_public_subnet_ids" {
    description = "IDs des subnets publics pour l'ALB"
    type        = list(string)
  
}

variable "alb_target_group_name" {
    description = "Nom du groupe cible pour l'ALB"
    type        = string
    default     = "my-app-tg"

}
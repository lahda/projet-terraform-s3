variable "subnet_ids" {
  description = "Liste des IDs des sous-réseaux"
  type        = list(string)
}

variable "db_name" {
  description = "Nom de la base de données"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Nom d'utilisateur de la base de données"
  type        = string
  default     = "admin"
}

variable "instance_class" {
  description = "Classe d'instance pour les instances RDS"
  type        = string
  default     = "db.t3.medium"
}

variable "instance_count" {
  description = "Nombre d'instances dans le cluster RDS"
  type        = number
  default     = 2
}

variable "environment" {
  description = "Environnement pour les ressources"
  type        = string
  default     = "dev"
}

variable "security_group_id" {
  description = "db security group"

}
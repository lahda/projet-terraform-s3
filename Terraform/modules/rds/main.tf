resource "random_password" "db" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "db" {
  name        = "rds-${var.environment}-db-credentials"
  description = "Master credentials for the ${var.environment} Aurora cluster"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db.result
    engine   = "aurora-mysql"
    host     = aws_rds_cluster.main.endpoint
    port     = aws_rds_cluster.main.port
    dbname   = var.db_name
  })
}

resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = {
    Environment = var.environment
  }

}

resource "aws_rds_cluster" "main" {
  cluster_identifier     = "rds-cluster-${var.environment}"
  engine                 = "aurora-mysql"
  engine_version         = "8.0.mysql_aurora.3.10.3"
  database_name          = var.db_name
  master_username        = var.db_username
  master_password        = random_password.db.result
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot    = true

  tags = {
    Environment = var.environment
  }

}

resource "aws_rds_cluster_instance" "main" {
  count               = var.instance_count
  identifier          = "rds-cluster-instance-${var.environment}-${count.index}"
  cluster_identifier  = aws_rds_cluster.main.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.main.engine
  engine_version      = aws_rds_cluster.main.engine_version
  publicly_accessible = false

  tags = {
    Environment = var.environment
  }

}
resource "aws_ecs_cluster" "main" {
    name = "ecs-cluster-${var.environment}-cluster"
    setting {
        name  = "containerInsights"
        value = "enabled"
    }

    tags = {
        Environment = "${var.environment}-cluster"
    }

}

resource "aws_ecs_service" "main" {
    name            = "ecs-service-${var.environment}"
    cluster         = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.main.arn
    desired_count   = 1
    launch_type     = "FARGATE"

    network_configuration {
        subnets          = var.subnet_ids
        security_groups  = [var.security_group_id]
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.target_group_arn
        container_name   = "app-container"
        container_port   = 80
    }

    tags = {
        Environment = var.environment
    }
}

resource "aws_ecs_task_definition" "main" {
    family                   = "ecs-task-${var.environment}"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = "256"
    memory                   = "512"

    container_definitions = jsonencode([
        {
            name      = "app-container"
            image     = "${var.ecr_repository_url}:latest"
            essential = true
            portMappings = [
                {
                    containerPort = var.container_port
                    hostPort      = var.host_port
                    protocol      = "tcp"
                }
            ]
        }
    ])

    tags = {
        name       = "ecs-task-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_cloudwatch_log_group" "main" {
    name              = "/ecs/ecs-task-${var.environment}-filrouge-app"
    retention_in_days = 7

    tags = {
        Environment = var.environment
    }
}

resource "aws_iam_role" "ecs_task_execution_role" {
    name = "ecs-task-execution-role-${var.environment}"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
            }
        ]
    })

    tags = {
        Environment = var.environment
    }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
    role       = aws_iam_role.ecs_task_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
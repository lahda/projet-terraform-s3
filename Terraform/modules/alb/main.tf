resource "aws_alb" "mon_alb" {
  name                       = var.alb_name
  internal                   = false
  security_groups            = [var.alb_security_group_id]
  subnets                    = var.alb_public_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name        = var.alb_name
    Environment = var.environment
  }

}

resource "aws_alb_target_group" "app_target_group" {
  name_prefix = "tg-"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path                = var.alb_target_group_health_check_path
    protocol            = "HTTP"
    interval            = var.alb_target_group_health_check_interval
    timeout             = var.alb_target_group_health_check_timeout
    healthy_threshold   = var.alb_target_group_health_check_healthy_threshold
    unhealthy_threshold = var.alb_target_group_health_check_unhealthy_threshold
    matcher             = var.alb_target_group_health_check_matcher
  }

  tags = {
    Name        = var.alb_target_group_name
    Environment = var.environment
  }

}

resource "aws_alb_listener" "HTTP" {
  load_balancer_arn = aws_alb.mon_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_target_group.arn
  }

}
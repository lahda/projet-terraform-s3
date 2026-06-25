output "alb_arn" {
    description = "ARN de l'application load balancer"
    value = aws_lb.main.arn
  
}

output "alb_dns_name" {
    description = "DNS name de l'application load balancer"
    value = aws_lb.main.dns_name
  
}

output "target_group_arn" {
    description = "ARN du groupe cible pour l'ALB"
    value = aws_lb_target_group.main.arn
  
}
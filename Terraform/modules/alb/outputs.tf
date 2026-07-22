output "alb_arn" {
    description = "ARN de l'application load balancer"
    value = aws_alb.mon_alb.arn

}

output "alb_dns_name" {
    description = "DNS name de l'application load balancer"
    value = aws_alb.mon_alb.dns_name

}

output "target_group_arn" {
    description = "ARN du groupe cible pour l'ALB"
    value = aws_alb_target_group.app_target_group.arn

}
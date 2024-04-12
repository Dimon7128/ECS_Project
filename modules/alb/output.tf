output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}
output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}
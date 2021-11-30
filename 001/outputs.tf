output "ssmrole" {
  value       = data.aws_iam_role.ssmrole
  description = "All the info for ssm quick setup"
}

output "alb_dns_name" {
  value = aws_lb.alb-web-farm.dns_name
}
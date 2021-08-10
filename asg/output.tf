output "asg_name" {
  value = aws_autoscaling_group.this.name
}

output "route53_zone_arn" {
  value = "arn:aws:route53:::hostedzone/${aws_route53_zone.this.zone_id}"
}

resource "aws_route53_zone" "this" {
  name = var.zone
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.name
  type    = "A"
  ttl     = "300"
  records = var.addresses
}

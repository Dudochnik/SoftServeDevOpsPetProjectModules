resource "aws_security_group" "this" {
  vpc_id = var.vpc_id
  name = var.name
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port = lookup(ingress.value, "from_port")
      to_port = lookup(ingress.value, "to_port")
      protocol = lookup(ingress.value, "protocol")
      cidr_blocks = lookup(ingress.value, "cidr_blocks")
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port = lookup(egress.value, "from_port")
      to_port = lookup(egress.value, "to_port")
      protocol = lookup(egress.value, "protocol")
      cidr_blocks = lookup(egress.value, "cidr_blocks")
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.name
  }
}

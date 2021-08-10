resource "aws_vpc" "this" {
  cidr_block = var.cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

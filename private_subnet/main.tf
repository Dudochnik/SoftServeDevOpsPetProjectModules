resource "aws_subnet" "this" {
  cidr_block = var.cidr
  vpc_id = var.vpc_id
  availability_zone = var.availability_zone

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "this" {
  route_table_id = var.route_table_id
  subnet_id      = aws_subnet.this.id
}

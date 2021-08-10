resource "aws_subnet" "this" {
  cidr_block = var.cidr
  vpc_id = var.vpc_id
  availability_zone = var.availability_zone

  tags = {
    Name = var.name
  }
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
}

resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.this.id
}

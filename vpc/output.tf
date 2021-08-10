output "id" {
  value = aws_vpc.this.id
}

output "gateway_id" {
  value = aws_internet_gateway.this.id
}

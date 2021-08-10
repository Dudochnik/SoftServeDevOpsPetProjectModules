resource "aws_instance" "this" {
  count                       = var.instances_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  subnet_id                   = var.subnet_ids[count.index]
  associate_public_ip_address = var.associate_public_ip
  user_data                   = var.user_data

  tags = {
    Name = "${var.name}-${var.subnet_ids[count.index]}"
  }
}

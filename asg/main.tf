resource "aws_launch_template" "this" {
  name                   = var.launch_template_name
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  user_data = base64encode(var.user_data)
  tags = {
    Name = var.launch_template_name
  }
}

resource "aws_autoscaling_group" "this" {
  vpc_zone_identifier = var.subnet_ids
  desired_capacity    = var.asg_size.desired_capacity
  min_size            = var.asg_size.min_size
  max_size            = var.asg_size.max_size
  health_check_type = var.health_check_type
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  target_group_arns = var.target_groups
  tag {
    key = "Domain"
    value = var.domain_name
    propagate_at_launch = true
  }
  tag {
    key = "Name"
    value = var.launch_template_name
    propagate_at_launch = true
  }
}

resource "aws_route53_zone" "this" {
  name = "${var.launch_template_name}.com"
  vpc {
    vpc_id = var.vpc_id
  }
}

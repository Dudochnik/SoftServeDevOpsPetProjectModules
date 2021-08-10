resource "aws_lb" "this" {
  name               = var.name
  internal           = var.is_internal
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "this" {
  name     = var.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    enabled = true
    protocol = "HTTP"
    port = 80
    path = "/"
    matcher = "200-299"
    timeout = 90
    interval = 120
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.listener_type
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = var.autoscaling_group_name
  alb_target_group_arn   = aws_lb_target_group.this.arn
}

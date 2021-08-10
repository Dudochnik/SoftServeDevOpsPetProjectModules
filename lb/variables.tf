variable "name" {
  type = string
}

variable "is_internal" {
  type = bool
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "load_balancer_type" {
  type = string
  default = "application"
}

variable "listener_type" {
  type = string
  default = "forward"
}

variable "autoscaling_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "ingress_rules" {
  type = map(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  type = map(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
}

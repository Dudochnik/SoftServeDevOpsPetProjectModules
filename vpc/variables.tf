variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "cidr_all" {
  type = string
  default = "0.0.0.0/0"
}

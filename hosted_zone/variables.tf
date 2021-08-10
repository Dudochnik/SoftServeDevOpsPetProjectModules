variable "zone" {
  type = string
}

variable "name" {
  type = string
}

variable "addresses" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "associate_public_ip" {
  type    = bool
  default = false
}

variable "instances_count" {
  type    = number
  default = 1
}

variable "user_data" {
  type    = string
  default = null
}

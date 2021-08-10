variable "launch_template_name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "asg_size" {
  type = object({
    min_size = number
    max_size = number
    desired_capacity = number
  })
}

variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "target_groups" {
  type = list(string)
  default = null
}

variable "vpc_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "user_data" {
  type = string
  default = ""
}

variable "health_check_type" {
  type = string
  default = "EC2"
}

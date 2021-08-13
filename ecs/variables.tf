variable "vpc_id" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "launch_type" {
  type = string
}

variable "task_cpu" {
  type = string
}

variable "task_memory" {
  type = string
}

variable "task_family_name" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "subnets" {
  type = list(string)
}

variable "network_mode" {
  type = string
  default = "awsvpc"
}

variable "requires_compatibilities" {
  type = list(string)
  default = ["FARGATE"]
}

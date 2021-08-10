data "aws_ami" "nixos" {
  owners = ["080433136561"]
  filter {
    name   = "image-id"
    values = ["ami-093cba49754abd7f8"]
  }
}

data "aws_ami" "bastion" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Bastion*"]
  }
}

data "aws_ami" "grafana" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Grafana*"]
  }
}

data "aws_ami" "prometheus" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Prometheus*"]
  }
}

data "aws_ami" "loki" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Loki*"]
  }
}

data "aws_ami" "cockroachdb" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["CockroachDB-Consul*"]
  }
}

data "aws_ami" "consul" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Consul*"]
  }
}

data "aws_ami" "apache" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Apache-Consul*"]
  }
}

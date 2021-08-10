output "nixos" {
  value = data.aws_ami.nixos.id
}

output "bastion" {
  value = data.aws_ami.bastion.id
}

output "grafana" {
  value = data.aws_ami.grafana.id
}

output "prometheus" {
  value = data.aws_ami.prometheus.id
}

output "loki" {
  value = data.aws_ami.loki.id
}

output "cockroachdb" {
  value = data.aws_ami.cockroachdb.id
}

output "consul" {
  value = data.aws_ami.consul.id
}

output "apache" {
  value = data.aws_ami.apache.id
}

#!/bin/bash
instance_id=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/instance-id)
private_ip=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/local-ipv4)
availability_zone=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
sed -i '0,/node_name = "apache";/s//node_name = "'"$instance_id"'";/' /etc/nixos/configuration.nix
sed -i '0,/services.consul.enable = false;/s//services.consul.enable = true;/' /etc/nixos/configuration.nix
sed -i '0,/job: apache-systemd-journal/s//job: '"$availability_zone"'-apache-systemd-journal/' /etc/nixos/promtail-config.yaml
sed -i '0,/job: apache/s//job: '"$availability_zone"'-apache/' /etc/nixos/promtail-config.yaml
sed -i '0,/$apache_ip = "";/s//$apache_ip = "'"$private_ip"'";/' /etc/nixos/index.tpl
/run/current-system/sw/bin/uuidgen > /var/consul/node-id
/run/current-system/sw/bin/nixos-rebuild switch
/run/current-system/sw/bin/consul-template -template "/etc/nixos/index.tpl:/var/www/index.php" -once

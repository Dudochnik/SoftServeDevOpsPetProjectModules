#!/bin/bash
instance_id=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/instance-id)
availability_zone=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
sed -i '0,/node_name = "consul";/s//node_name = "'"$instance_id"'";/' /etc/nixos/configuration.nix
sed -i '0,/enable = false;/s//enable = true;/' /etc/nixos/configuration.nix
sed -i '0,/systemd.services.promtail.enable = false;/s//systemd.services.promtail.enable = true;/' /etc/nixos/configuration.nix
sed -i '0,/job: consul-systemd-journal/s//job: '"$availability_zone"'-consul-systemd-journal/' /etc/nixos/promtail-config.yaml
sed -i '0,/job: consul/s//job: '"$availability_zone"'-consul/' /etc/nixos/promtail-config.yaml
/run/current-system/sw/bin/uuidgen > /var/consul/node-id
/run/current-system/sw/bin/nixos-rebuild switch

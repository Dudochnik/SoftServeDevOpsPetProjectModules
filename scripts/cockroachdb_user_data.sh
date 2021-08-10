#!/bin/bash
private_ip=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/local-ipv4)
instance_id=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/instance-id)
availability_zone=$(/run/current-system/sw/bin/curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
sed -i '0,/node_name = "cockroachdb";/s//node_name = "'"$instance_id"'";/' /etc/nixos/configuration.nix
sed -i '0,/services.consul.enable = false;/s//services.consul.enable = true;/' /etc/nixos/configuration.nix
/run/current-system/sw/bin/uuidgen > /var/consul/node-id
/run/current-system/sw/bin/uuidgen > /etc/machine-id
/run/current-system/sw/bin/nixos-rebuild switch
/run/current-system/sw/bin/sleep 10s
/run/current-system/sw/bin/consul kv put cockroachdb/"$availability_zone" "$private_ip"
sed -i '0,/systemd.services.cockroachdb.enable = false;/s//systemd.services.cockroachdb.enable = true;/' /etc/nixos/configuration.nix
sed -i '0,/db_zone/s//'"$availability_zone"'/' /etc/nixos/cockroachdb-launcher.tpl
/run/current-system/sw/bin/nixos-rebuild switch

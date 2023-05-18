#!/bin/bash
sudo apt-get update
sudo apt update
sudo debconf-set-selections <<EOF
iptables-persistent iptables-persistent/autosave_v4 boolean true
iptables-persistent iptables-persistent/autosave_v6 boolean true
EOF
sudo apt-get -y install iptables-persistent
sudo iptables -t nat -A POSTROUTING -s 10.0.1.0/24 -j MASQUERADE
sudo su
iptables-save > /etc/iptables/rules.v4
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sysctl -p
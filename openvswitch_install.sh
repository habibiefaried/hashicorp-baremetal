#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
apt update && apt install iptables openvswitch-* -y # Choose racoon
#!/bin/bash
set -e
VM_NAME="vm-labs"

echo "==> Start Link Docker with CoreDNS … ..."
echo "===================================="
sudo nano /etc/docker/daemon.json

{
  "dns": ["DNS_IP_Address", "8.8.8.8"]
}

# Restart Docker
sudo systemctl restart docker

echo "==> Done! Link Docker with CoreDNS ..."

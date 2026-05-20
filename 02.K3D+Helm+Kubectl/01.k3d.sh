#!/bin/bash
set -e
VM_NAME="vm-labs"

echo "==> Start K3D Cluster Toolbar… ..."
echo "===================================="
# k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# kubectl
curl -LO https://dl.k8s.io/release/v1.35.0/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo kubectl version || true

# Create Cluster K3D (running in port 8080 -> 80 LB inside K8s
sudo k3d cluster create tdc-cluster \
  --agents 3 \
  --port "8080:80@loadbalancer" || true

# Check cluster
sudo k3d cluster list

# Check nodes
sudo kubectl cluster-info
sudo kubectl get nodes
sudo kubectl get pods

# Install K9S
sudo snap install k9s
sudo ln -s /snap/k9s/current/bin/k9s /snap/bin/k9s
echo ""Finish install k9s

echo "==> Done! K3D Cluster ..."

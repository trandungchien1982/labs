#!/bin/bash
set -e
VM_NAME="vm-labs"

echo "==> Mapping CoreDNS for K3D cluster … ..."
echo "===================================="

KUBE_EDITOR="nano" kubectl -n kube-system edit configmap coredns

# Find this row:
#   forward . /etc/resolv.conf
# And Update:
#   forward . {IP DNS Server}

# Restart K3d cluster
kubectl rollout restart deployment coredns -n kube-system

# For testing if we can PING any domain that have been configured in DNS Server
# Go to Container Ubuntu 24.04 directly via bash
#   kubectl run ubuntu-dns-test --image=ubuntu:24.04 --restart=Never -it -- bash
#   apt update
#   apt install -y iputils-ping dnsutils
#
# Double check config of CoreDNS
# kubectl -n kube-system get configmap coredns -o yaml

echo "==> Done! Core DNS ..."
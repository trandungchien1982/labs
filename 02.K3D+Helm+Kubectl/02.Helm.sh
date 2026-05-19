#!/bin/bash
set -e
VM_NAME="vm-labs"

echo "==> Install Helm … ..."
echo "===================================="
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

which helm

# Some testing
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo nginx

# Verify Helm has been working properly on k3d
helm ls -A

# Testing Helm : Install nginx into k3d
# helm install my-nginx bitnami/nginx
# kubectl get pods
# kubectl get svc
# kubectl port-forward --address 0.0.0.0 svc/my-nginx 9090:80

# Execute by URL : http://localhost:9090
# or URL         : http://vm-labs:9090

echo "==> Done! Helm Chart ..."
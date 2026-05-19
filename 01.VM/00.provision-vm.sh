#!/usr/bin/env bash
set -e

# Provision the Ubuntu 24.04 LTS using Multipass + Terraform
# VM Name, e.g. vm-labs
VM_NAME="vm-labs"

# Result file contains the VM IP Address + Creation Time
RESULT_FILE="result.yaml"

echo "==> Checking dependencies..."
echo " -- New VM will be created: VM_NAME = $TF_VAR_VM_NAME "
command -v multipass >/dev/null || { echo "Multipass not installed"; exit 1; }
command -v terraform >/dev/null || { echo "Terraform not installed"; exit 1; }

echo "==> Reading SSH public key..."
PUB_KEY=$(cat ~/.ssh/id_rsa.pub)

cd terraform

echo "==> Injecting SSH key into cloud-init..."
sed -i.bak "s|__SSH_KEY__|${PUB_KEY}|g" cloud-init.yaml

echo "==> Initializing Terraform..."
terraform init

echo "==> Applying Terraform..."
terraform apply -auto-approve

echo "==> Fetching VM IP..."
VM_IP=$(terraform output -raw vm_ip)

cd ..

echo "==> Writing result.yaml..."
cat > ${RESULT_FILE} <<EOF
targetVM: ${VM_IP}
finishedAt: $(date -Iseconds)
EOF


echo "===================================="
echo "Provisioning completed!"
echo "VM IP: ${VM_IP}"
echo "===================================="

echo "======================================="
echo "Try to mount folder to main host"
mkdir ~/tdchien-mount/$VM_NAME
multipass mount ~/tdchien-mount/$VM_NAME $VM_NAME:/root/$VM_NAME
echo "Finish mounting folder : ~/tdchien-mount/$VM_NAME into $VM_NAME:/root/$VM_NAME"
echo "===================== End provision ... "
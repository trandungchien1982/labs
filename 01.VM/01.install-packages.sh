#!/bin/bash
set -e

VM_NAME="vm-labs"

# Install standard packages, e.g. Docker, Docker Compose, Java, Maven, Gradle, ...
echo "===================================="
echo "Current VM NAME: $VM_NAME"
echo "Call action after provision finish, prevent timeout error ..."
multipass transfer zz.01.install-packages.sh $VM_NAME:/home/ubuntu/
multipass exec $VM_NAME -- chmod +x /home/ubuntu/zz.01.install-packages.sh
multipass exec $VM_NAME -- /home/ubuntu/zz.01.install-packages.sh
echo "===================================="

echo "==> Done!"
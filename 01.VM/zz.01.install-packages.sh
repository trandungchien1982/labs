#!/bin/bash
set -e
VM_NAME="vm-labs"

# Install standard packages, e.g. Docker, Docker Compose, Java, Maven, Gradle, ...
echo "==> Updating system..."
sudo apt update


echo "==> Installing base packages..."
sudo apt install -y docker.io docker-compose curl


echo "==> Enable Docker..."
sudo systemctl enable docker
sudo systemctl start docker


echo "==> Install Java ... default is JDK 21 ..."
sudo apt install default-jdk
sudo java -version
sudo javac -version


echo "==> Git/Maven ..."
sudo apt install git
sudo git --version

sudo apt install -y maven default-jdk
sudo mvn --batch-mode --no-transfer-progress -version


echo "==> Install Curl"
sudo apt install -y default-jdk ca-certificates curl


echo "==> Install Gradle ..."
sudo apt install gradle -y
sudo gradle -v


echo "==> Done!"
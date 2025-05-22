#!/bin/bash

# Exit on any error
set -e

echo "Updating package list . . ."
apt update

echo "Installing default jdk . . ."
apt install -y default-jdk

echo "Installing other required packages"
apt install -y wget curl ca-certificates

echo "Adding jenkins repo and key . . ."
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
echo "Updating package list . . ."
apt update

echo "Installing jenkins . . ."
apt install -y jenkins

echo "Starting and enabling jenkins . . ."
systemctl enable --now jenkins


echo "Installing docker . . ."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Starting and enabling docker . . ."
systemctl enable --now docker

echo "Initial admin password . . ."
echo "#############################################"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "#############################################"
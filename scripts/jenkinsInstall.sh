#!/bin/bash

# Exit on any error
set -e

echo "Updating package list . . ."
apt update

echo "Installing default jdk . . ."
apt install -y default-jdk

echo "Installing wget and curl"
apt install -y wget curl

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

echo "Starting and enabling jenkins service . . ."
systemctl enable --now jenkins

echo "Waiting for jenkins to start . . ."
sleep 120

echo "Initial admin password . . ."
echo "#############################################"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "#############################################"
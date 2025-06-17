#!/bin/bash

set -e

echo "🚀 Starting developer environment setup..."

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Essential build tools
sudo apt install -y build-essential curl wget git unzip zip software-properties-common

# Python + pip + venv
sudo apt install -y python3 python3-pip python3-venv

# Node.js (LTS version)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Java (OpenJDK 17)
sudo apt install -y openjdk-17-jdk

# Go (latest from Go's site)
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text)
wget https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf ${GO_VERSION}.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
rm ${GO_VERSION}.linux-amd64.tar.gz

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# C/C++ (already included with build-essential)

# Ruby
sudo apt install -y ruby-full

# PHP
sudo apt install -y php php-cli php-mbstring

# Docker (optional but useful)
sudo apt install -y ca-certificates gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Final message
echo "✅ All environments installed!"
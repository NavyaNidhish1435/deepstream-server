#!/bin/bash

echo "===== DeepStream Auto Deployment ====="

sudo apt update

# Install docker if missing
if ! command -v docker &> /dev/null
then
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
fi

# Install NVIDIA toolkit
if ! dpkg -l | grep -q nvidia-container-toolkit; then
    sudo apt install -y nvidia-container-toolkit
    sudo systemctl restart docker
fi

docker compose build
docker compose up -d

echo "DeepStream Started"

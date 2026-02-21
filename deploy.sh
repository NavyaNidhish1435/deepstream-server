#!/bin/bash

echo "========== DeepStream Smart Deployment =========="

IMAGE="nvcr.io/nvidia/deepstream:6.4-samples-multiarch"

echo ""
echo "Checking access to NVIDIA NGC registry..."

# Try pulling image silently
docker pull $IMAGE >/dev/null 2>&1

# If pull failed → probably not logged in
if [ $? -ne 0 ]; then
    echo ""
    echo "NGC authentication required."
    echo "Paste your NVIDIA NGC API Key:"
    
    read -s NGC_API_KEY
    echo ""

    echo "$NGC_API_KEY" | docker login nvcr.io \
        --username '$oauthtoken' \
        --password-stdin

    if [ $? -ne 0 ]; then
        echo "❌ Login failed. Deployment stopped."
        exit 1
    fi

    echo "✅ Login successful."
fi

echo ""
echo "Pulling latest DeepStream image..."
docker pull $IMAGE

echo ""
echo "Building container..."
docker compose build

echo ""
echo "Starting DeepStream container..."
docker compose up -d

echo ""
echo "✅ DeepStream is running!"
echo "Check logs using:"
echo "docker logs -f deepstream_server"

#!/bin/bash

echo "===== DeepStream Safe Deployment ====="

# Check if already logged into nvcr.io
if ! docker system info 2>/dev/null | grep -q nvcr.io; then
    echo ""
    echo "NVIDIA NGC login required."
    echo "Enter your NVIDIA NGC API Key:"
    
    read -s NGC_API_KEY

    echo "$NGC_API_KEY" | docker login nvcr.io \
        --username '$oauthtoken' \
        --password-stdin

    if [ $? -ne 0 ]; then
        echo "❌ NGC login failed"
        exit 1
    fi
fi

echo ""
echo "Building DeepStream container..."
docker compose build

echo "Starting DeepStream..."
docker compose up -d

echo ""
echo "✅ DeepStream running successfully"

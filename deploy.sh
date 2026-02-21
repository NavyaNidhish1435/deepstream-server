#!/bin/bash

echo "Starting DeepStream container..."

docker compose build
docker compose up -d

echo "DeepStream running safely."

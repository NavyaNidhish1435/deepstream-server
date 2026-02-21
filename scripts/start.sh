#!/bin/bash

echo "Starting DeepStream (Headless Mode)..."

export DISPLAY=

deepstream-app -c configs/deepstream_app_config.txt

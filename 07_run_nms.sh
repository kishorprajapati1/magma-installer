#!/bin/bash
set -e
echo "🖥️ Starting Magma NMS (Magmalte)..."

cd /home/ubuntu/magma/nms
COMPOSE_PROJECT_NAME=magmalte docker-compose build magmalte
docker-compose up -d
python3 ./scripts/dev_setup.sh

echo "✅ NMS is up and configured!"

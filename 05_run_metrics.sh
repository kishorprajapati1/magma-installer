#!/bin/bash
set -e
echo "📊 Starting Orchestrator metrics services..."

cd /home/ubuntu/magma/orc8r/cloud/docker
python3 ./run.py --metrics

echo "✅ Metrics services started!"

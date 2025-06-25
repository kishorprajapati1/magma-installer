#!/bin/bash
set -e
echo "?? Running Magma Orchestrator using build.py..."

cd /home/ubuntu/magma/orc8r/cloud/docker

python3 build.py --all

echo "? Magma Orchestrator is up!"

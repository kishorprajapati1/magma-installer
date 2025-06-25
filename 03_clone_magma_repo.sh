#!/bin/bash
set -e
echo "📥 Cloning Magma v1.9..."

cd ~

if [ -d "magma" ]; then
  echo "⚠️ Directory 'magma' already exists. Skipping clone."
else
  git clone https://github.com/kishorprajapati1/magma.git
fi

cd magma

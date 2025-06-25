#!/bin/bash
set -e
echo "📄 Copying test certificates to /var/opt/magma/certs..."

if [ ! -d "$HOME/magma/.cache/test_certs" ]; then
    echo "⚠️ Test certs not found. Make sure './build.py --all' has been run to generate them."
    exit 1
fi

sudo mkdir -p /var/opt/magma/certs/
sudo cp -r /home/ubuntu/magma/.cache/test_certs/* /var/opt/magma/certs/
sudo chmod -R 777 /var/opt/magma/certs/

echo "✅ Certificates copied!"

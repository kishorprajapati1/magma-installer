#!/bin/bash

echo "Starting full cleanup of Magma, Docker, VirtualBox, Bazel, Ansible, and cache files..."

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 1: Stop Magma services (if any)
if systemctl list-units --type=service | grep -q magma; then
    echo "Stopping Magma services..."
    sudo systemctl stop magma@*
    sudo systemctl disable magma@*
fi

# Step 2: Remove Magma files
echo "Removing Magma files and folders..."
sudo rm -rf /var/opt/magma /etc/magma /opt/magma /usr/local/lib/magma
sudo rm -rf ~/magma ~/magma-dev ~/.cache/magma /tmp/magma*
sudo rm -rf /usr/local/bin/magma* /usr/local/bin/agw* /usr/local/bin/envdir

# Step 3: Remove Docker
if command_exists docker; then
    echo "Removing Docker..."
    sudo systemctl stop docker
    sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo rm -rf /var/lib/docker /etc/docker ~/.docker
fi

# Step 4: Remove VirtualBox
if command_exists virtualbox; then
    echo "Removing VirtualBox..."
    sudo apt-get purge -y virtualbox virtualbox-ext-pack
    sudo rm -rf ~/VirtualBox\ VMs ~/.config/VirtualBox
fi

# Step 5: Remove Vagrant
if command_exists vagrant; then
    echo "Removing Vagrant..."
    sudo apt-get purge -y vagrant
    sudo rm -rf ~/.vagrant.d
fi

# Step 6: Remove Bazel and Bazelisk
if command_exists bazel || command_exists bazelisk; then
    echo "Removing Bazel and Bazelisk..."
    sudo rm -f /usr/local/bin/bazel /usr/bin/bazel
    sudo rm -f /usr/local/bin/bazelisk /usr/bin/bazelisk
    sudo rm -rf ~/.bazel* ~/.cache/bazel ~/.cache/bazelisk ~/.cache/bazel-repo
    sudo apt-get purge -y bazel
fi

# Step 7: Remove Ansible
if command_exists ansible; then
    echo "Removing Ansible..."
    sudo apt-get purge -y ansible
    sudo rm -rf ~/.ansible
fi

# Step 8: Clean caches
echo "Cleaning up system cache and temporary files..."
sudo apt-get autoremove -y
sudo apt-get autoclean
sudo rm -rf ~/.cache/*
sudo rm -rf /var/cache/apt/archives/*
sudo rm -rf /var/tmp/*

echo "✅ Full cleanup completed."

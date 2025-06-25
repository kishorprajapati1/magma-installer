#!/bin/bash
set -e

echo "?? Updating system and installing base dependencies..."
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common \
  gnupg-agent lsb-release git unzip make python3-pip

echo ""
echo "?? Installing Go 1.18.3..."
wget https://linuxfoundation.jfrog.io/artifactory/magma-blob/go1.18.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.18.3.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin
go version

echo ""
echo "?? Installing pyenv and Python 3.8.10..."

# Install pyenv dependencies
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
  liblzma-dev python3-openssl git

# Clone pyenv
if [ ! -d "$HOME/.pyenv" ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

# Setup pyenv in bashrc
if ! grep -q 'PYENV_ROOT' ~/.bashrc; then
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
fi

# Source the new bash config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Install Python version
if ! pyenv versions | grep -q 3.8.10; then
  pyenv install 3.8.10 || CFLAGS="-O2" pyenv install 3.8.10
fi
pyenv global 3.8.10

echo ""
echo "?? Installing pip3 dependencies..."
sudo apt install -y python3-pip
pip3 install ansible fabric3 jsonpickle requests PyYAML

echo ""
echo "? Dependencies, Go 1.18.3, pyenv, Python 3.8.10, and pip3 setup complete!"

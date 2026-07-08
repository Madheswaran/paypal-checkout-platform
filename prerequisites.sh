#!/bin/bash

echo "Installing C++ development tools..."

sudo apt update

sudo apt install -y \
    curl \
    unzip \
    pkg-config

sudo apt install -y \
    build-essential \
    cmake \
    gdb \
    tree

echo
echo "Installed versions:"
g++ --version | head -1
cmake --version | head -1
make --version | head -1

#apt-get install -y git
#git clone https://github.com/Madheswaran/paypal-checkout-platform.git
git config --global user.name "Madheswaran Selvakumar"
git config --global user.email "madheswaran.selvakumar@gmail.com"


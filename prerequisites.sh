#!/bin/bash

echo "Installing C++ development tools..."

sudo apt update

sudo apt install -y \
    curl \
    docker.io \
    tree

systemctl start docker
#apt-get install -y git
#git clone https://github.com/Madheswaran/paypal-checkout-platform.git
git config --global user.name "Madheswaran Selvakumar"
git config --global user.email "madheswaran.selvakumar@gmail.com"


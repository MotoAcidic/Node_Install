#!/bin/bash

sudo apt update
sudo apt upgrade -y

# developer tools packages
sudo apt install -y git gcc make

# Go setup enviroment
sudo snap install --classic go

mkdir -p $HOME/go/bin

echo "export GOPATH=$HOME/go" >> ~/.bash_profile
echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.bash_profile
source ~/.bash_profile


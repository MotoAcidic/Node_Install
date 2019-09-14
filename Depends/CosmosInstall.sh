#!/bin/bash

echo Starting the install process.
echo Checking and installing VPS server prerequisites. Please wait.

# Core depends for any crypto project
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y 
sudo snap install --classic go -y
sudo apt install -y git gcc make -y
sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git -y
sudo apt-get install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler -y
sudo apt update && apt install build-essential checkinstall zlib1g-dev libtemplate-perl -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev -y
sudo apt-get install libzmq3-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo apt-get install libgmp3-dev libevent-dev bsdmainutils libboost-all-dev openssl -y
sudo apt-get install libssl1.0-dev -y
sudo apt-get install -y autoconf g++ make openssl libssl-dev libcurl4-openssl-dev -y
sudo apt-get install -y libcurl4-openssl-dev pkg-config -y
sudo apt-get install -y libsasl2-dev -y

# Install golang
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
snap install gvm


# Update Go
sudo rm -rf /usr/local/go
git clone https://github.com/udhos/update-golang
cd update-golang
sudo ./update-golang.sh

# Make Go folder and edit file
mkdir -p $HOME/go/bin
echo "export GOPATH=$HOME/go" >> ~/.bash_profile
echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.bash_profile
source ~/.bash_profile

clear
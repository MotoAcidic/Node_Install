#!/bin/bash

# Install guide https://medium.com/forbole/a-step-by-step-guide-to-join-cosmos-hub-testnet-e591a3d2cb41

###############
# Colors Keys #
###############
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

############################
# Bring in the coins specs #
############################
source ./specs.sh

###################
# Install Depends #
###################
cd
cd $DEPENDS_PATH
bash CosmosInstall.sh
clear
echo Cosmos depends installed.

################
# Install Gaia #
################
mkdir -p $GOPATH/src/github.com/
cd $GOPATH/src/github.com
git clone -b release/v2.0.0 https://github.com/cosmos/gaia 
cd gaia && make install
cd

######################
# Install Cosmos SDK #
######################
mkdir -p $GOPATH/src/github.com/cosmos
cd $GOPATH/src/github.com/cosmos
git clone https://github.com/cosmos/cosmos-sdk
cd cosmos-sdk && git checkout v0.34.3
make tools install
make

############################
# Moniker File Name Choice #
############################
echo Enter the name of the Moniker. Monikers can contain only ASCII characters. Using Unicode characters will render your node unreachable.
read MONIKER
gaiad init $MONIKER
cd
mkdir -p $HOME/.gaiad/config
curl https://raw.githubusercontent.com/cosmos/launch/master/genesis.json > $HOME/.gaiad/config/genesis.json

##########################################
# Start the daemon to sync the full node #
##########################################
gaiad start --log_level="*:info"

##########################
# Head back to selection #
##########################
cd 
bash Node_Install/Coins/CosmosInstall.sh

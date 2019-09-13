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
bash validator-dpeneds.sh
clear
echo Validator depends installed.




git clone -b v2.0.0 https://github.com/cosmos/gaia
cd gaia && make install

# Now check your gaiad version.
gaiad version --long

# Get the genesis.json and connect to the testnet
gaiad unsafe-reset-all

# This will create .gaiad/config directory in your home directory with the following files.
~/.gaiad/config$ ls
config.toml  app.toml  priv_validator.json

# Then you can download the genesis.json file of the gaia-13006 to your configuration directory.
wget https://raw.githubusercontent.com/cosmos/testnets/master/gaia-13k/genesis.json -o $HOME/.gaiad/config/genesis.json

# Make sure the genesis.json file in your configuration directory is the correct one by checking the checksum.
shasum -a 256 genesis.json

# Next, edit some configurations which let you have an identity and be able to connect to some peers on gaia-13006.
nano $HOME/.gaiad/config/config.toml


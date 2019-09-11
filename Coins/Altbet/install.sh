#!/bin/bash

########################################################################################################
# COPY THIS FILE AND CHANGE ONLY THE SPECS BELOW FOR YOUR COIN                                         #
# Must use exact repo name: Example github https://github.com/altbet/abet Example repo name: altbet    #
########################################################################################################
RPC_PORT=9322
COIN_PORT=8322
COIN_NAME='Altbet'
REPO_NAME='abet'
COIN_DAEMON='altbetd'
COIN_CLI='altbet-cli'
GITHUB=https://github.com/altbet/abet

###############
# Dont Change #
###############
DEPENDS="/Node_Install/Depends/install.sh"
EXTIP=`curl -s4 icanhazip.com`
RPCUSER=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
RPCPASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
COIN_PATH=.$REPO_NAME/

###################
# Install Depends #
###################
bash "$DEPENDS"
clear
echo VPS Server prerequisites installed.

#################################
# Make sure firewall is opened. #
#################################
  echo -e "Installing and setting up firewall to allow ingress on port ${GREEN}$COIN_PORT${NC}"
  ufw allow $COIN_PORT/tcp comment "$COIN_NAME MN port" >/dev/null
  ufw allow ssh comment "SSH" >/dev/null 2>&1
  ufw limit ssh/tcp >/dev/null 2>&1
  ufw default allow outgoing >/dev/null 2>&1
  echo "y" | ufw enable >/dev/null 2>&1

####################
# Compile the Coin #
####################
cd
git clone $GITHUB
sudo chmod -R 755 $REPO_NAME
cd $REPO_NAME
./autogen.sh
./configure --with-incompatible-bdb --disable-tests --with-gui=no
make install
cd

##############################
# Masternode Genkey Creation #
##############################
  echo -e "Enter your ${RED}$COIN_NAME Masternode Private Key${NC}. Leave it blank to generate a new ${RED}Masternode Private Key${NC} for you:"
  read -e COINKEY
  if [[ -z "$COINKEY" ]]; then
  $COIN_PATH$COIN_DAEMON -daemon
  sleep 30
  if [ -z "$(ps axo cmd:100 | grep $COIN_DAEMON)" ]; then
   echo -e "${RED}$COIN_NAME server couldn not start. Check /var/log/syslog for errors.{$NC}"
   exit 1
  fi
  COINKEY=$($COIN_PATH$COIN_CLI masternode genkey)
  if [ "$?" -gt "0" ];
    then
    echo -e "${RED}Wallet not fully loaded. Let us wait and try again to generate the Private Key${NC}"
    sleep 30
    COINKEY=$($COIN_PATH$COIN_CLI masternode genkey)
  fi
  $COIN_PATH$COIN_CLI stop
fi
clear

##########################
# Create the Config file #
##########################
mkdir $COIN_PATH
echo listen=1 > $COIN_PATH/$REPO_NAME.conf
echo server=1 >> $COIN_PATH/$REPO_NAME.conf
echo daemon=1 >> $COIN_PATH/$REPO_NAME.conf
echo staking=0 >> $COIN_PATH/$REPO_NAME.conf
echo rpcuser=testuser >> $COIN_PATH/$REPO_NAME.conf
echo rpcpassword=testpassword >> $COIN_PATH/$REPO_NAME.conf
echo rpcallowip=127.0.0.1 >> $COIN_PATH/$REPO_NAME.conf
echo rpcbind=127.0.0.1 >> $COIN_PATH/$REPO_NAME.conf
echo maxconnections=24 >> $COIN_PATH/$REPO_NAME.conf
echo masternode=1 >> $COIN_PATH/$REPO_NAME.conf
echo masternodeprivkey=$COINKEY >> $COIN_PATH/$REPO_NAME.conf
echo bind=$EXTIP >> $COIN_PATH/$REPO_NAME.conf
echo externalip=$EXTIP >> $COIN_PATH/$REPO_NAME.conf
echo masternodeaddr=$EXTIP:$COIN_PORT >> $COIN_PATH/$REPO_NAME.conf

##################
# Run the daemon #
##################
$COIN_DAEMON

watch $COIN_PATH$COIN_CLI
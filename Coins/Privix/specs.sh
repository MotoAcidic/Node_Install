#!/bin/bash

########################################################################################################
# COPY THIS FILE AND CHANGE ONLY THE SPECS BELOW FOR YOUR COIN                                         #
# Must use exact repo name: Example github https://github.com/altbet/abet Example repo name: altbet    #
########################################################################################################

RPC_PORT=7789
COIN_PORT=7788
COIN_NAME='Privix'
REPO_NAME='privix-core'
COIN_DAEMON='privixd'
COIN_CLI='privix-cli'
GITHUB=https://github.com/privix/privix-core

########################################
# DO NOT CHANGE BELOW STATIC VARIABLES #
########################################

COIN_PATH=/root/.$REPO_NAME
DAEMON_PATH=$REPO_NAME/src/$COIN_DAEMON
CLI_PATH=$REPO_NAME/src/$COIN_CLI

DEPENDS_PATH="Node_Install/Depends/"
DEPENDS_SCRIPT="install.sh"
EXTIP=`curl -s4 icanhazip.com`
RPCUSER=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
RPCPASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
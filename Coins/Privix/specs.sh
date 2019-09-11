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
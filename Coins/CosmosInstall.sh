#!/bin/bash
# Copyright (c) 2019 Tfinch. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="Cosmos Setup Wizard"
TITLE="Cosmos Install Setup"
MENU="Choose one of the following coins to install:"

OPTIONS=(1 "Cosmos Full Node"
		 0 "Exit"
)


CHOICE=$(whiptail --clear\
		--backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        0)  # Exit
		exit	
		;;

        1)	# Cosmos
		cd Cosmos
		bash MainNetFullNode.sh
        ;; 

esac
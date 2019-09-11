#!/bin/bash
# Copyright (c) 2019 Tfinch. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="Node Install Setup Wizard"
TITLE="Node Install Setup"
MENU="Choose one of the following coins to install:"

OPTIONS=(1 "Altbet"
		 2 "Privix"
		 0 "Exit Script"
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

        1)	# Altbet
		cd Altbet
		bash install.sh
        ;; 
		2)	# Privix
		cd Privix
		bash install.sh
        ;; 
esac
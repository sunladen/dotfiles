#!/usr/bin/env bash

if [ "${EUID}" -ne 0 ]; then
	echo "requires run as root; i.e. sudo ./update.sh"
	exit
fi


# Full apt update, upgrade, remove, clean cycle
apt update
apt upgrade -y
apt dist-upgrade -y
apt autoremove -y
apt autoclean -y


# Check for specific tool updates
#. ./tmux_update.sh
. ./vim_update.sh

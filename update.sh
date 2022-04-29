#!/usr/bin/env bash


# Full apt update, upgrade, remove, clean cycle
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y


# Check for specific tool updates
./vim_update.sh

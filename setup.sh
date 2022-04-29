#!/usr/bin/env bash

touch ~/.hushlogin

rm -f ~/.profile

mkdir -p ~/.config

rm -rf ~/.bash_aliases && ln -s $PWD/bash/.bash_aliases ~/.bash_aliases
rm -rf ~/.bash_profile && ln -s $PWD/bash/.bash_profile ~/.bash_profile
rm -rf ~/.bashrc && ln -s $PWD/bash/.bashrc ~/.bashrc
rm -rf ~/.inputrc && ln -s $PWD/bash/.inputrc ~/.inputrc
rm -rf ~/.vim && ln -s $PWD/.vim ~/.vim
rm -rf ~/.config/nvim && ln -s $PWD/.config/nvim ~/.config/nvim
rm -rf ~/.tmux.conf && ln -s $PWD/.tmux.conf ~/.tmux.conf
rm -rf ~/.config/ranger && ln -s $PWD/.config/ranger ~/.config/ranger

. ~/.bashrc

read -r -p "run package purge, install and updates (requires sudo)? [Yn] " response
case "$response" in
	[Yy])
		;;
	*)
		exit
		;;
esac

#sudo apt purge --auto-remove -y python3
#sudo apt purge --auto-remove -y libpython3.8
sudo apt purge --auto-remove -y tmux
sudo apt purge --auto-remove -y nano
sudo apt purge --auto-remove -y vim-common

# Full apt update, upgrade, remove, clean cycle
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y


# List installed packages
#sudo apt list --installed

# Read size of WSL distro excluding Windows drive mount
#sudo du -sh / --exclude=/mnt/c


#sudo apt install -y build-essential
#sudo apt install -y libncurses-dev

#sudo ./update.sh

#!/usr/bin/env bash

# global git config
git config --global user.email "sunladenmail@gmail.com"
git config --global user.name "sunladen"
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"


# disable login banner
touch ~/.hushlogin


# make sure there is a $HOME/.config directory
mkdir -p ~/.config


# symlink .dotfiles
rm -rf ~/.bash_aliases && ln -s $PWD/bash/.bash_aliases ~/.bash_aliases
rm -rf ~/.bash_profile && ln -s $PWD/bash/.bash_profile ~/.bash_profile
rm -rf ~/.bashrc && ln -s $PWD/bash/.bashrc ~/.bashrc
rm -rf ~/.inputrc && ln -s $PWD/bash/.inputrc ~/.inputrc
rm -rf ~/.vim && ln -s $PWD/.vim ~/.vim
rm -rf ~/.config/nvim && ln -s $PWD/.config/nvim ~/.config/nvim
rm -rf ~/.tmux.conf && ln -s $PWD/.tmux.conf ~/.tmux.conf
rm -rf ~/.config/ranger && ln -s $PWD/.config/ranger ~/.config/ranger


# install Node Version Manager (nvm) if not available
export NVM_DIR="$HOME/.nvm"
if [ ! -d $NVM_DIR ]; then
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
	git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  . "$NVM_DIR/nvm.sh"
fi


# install Tmux Plugin Manager (tpm) if not available
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d $TPM_DIR ]; then
	git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi


# question whether to go on and perform package management and tool installs
read -r -p "run package purge, install and updates (requires sudo)? [Yn] " response
case "$response" in
	[Yy])
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

		sudo apt install -y wsl
		sudo apt install -y fzf
		sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep

		sudo ./update.sh
		;;
esac



# source new symlinked $HOME/.bashrc
. ~/.bashrc

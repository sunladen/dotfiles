#!/usr/bin/env bash

# Install latest vim

tarball_url=$(curl -sL https://api.github.com/repos/vim/vim/tags | grep -Po '"tarball_url":[ ]*"\K[^"]+' | head -1)
echo "$tarball_url"
exit
#latest_filename=$(basename "$latest_release")
#latest_dirname=$(echo "$latest_filename" | sed "s/\.tar\.gz//")
#latest_version=$(echo "$latest_dirname" | sed "s/tmux-/tmux /")

install_latest=0

#if command -v tmux &> /dev/null; then
#	installed_version=$(tmux -V 2> /dev/null | head -1)
#	if [ "$installed_version" != "$latest_version" ]; then
#		echo "installed version $installed_version, newer version $latest_version available"
#		install_latest=1
#	else
#		echo "installed version $installed_version is up-to-date"
#	fi
#else
#	install_latest=1
#fi

if [ "$install_latest" -eq "1" ]; then
	read -r -p "install $latest_version? [Yn] " response
	case "$response" in
		[Yy])
			;;
		*)
			exit
			;;
	esac
else
	echo "exit 0"
fi

if [ "${EUID}" -ne 0 ]; then
	echo "installing requires run as root; i.e. sudo ./tmux_update.sh"
	exit
fi



# Check for known dependancies
required=()
missing=()
for package in "${required[@]}"; do
	checking="checking for ${package}... "
	if dpkg-query -l "$package" &> /dev/null; then
		checking="${checking}yes"
	else
		checking="${checking}no"
		missing+=("${package}")
	fi
	echo ${checking}
done


if [ ${#missing[@]} -gt 0 ]; then
	echo "installing ${#missing[@]} packages..."
fi


for package in "${missing[@]}"; do
	apt --yes install "${package}"
done


cd /tmp

echo $latest_tag
wget -O "vim-latest.tar.gz" "$tarball_url"
extracted_dir=$(tar xvf "vim-latest.tar.gz" | head -1)
tar xvf "vim-latest.tar.gz" 
cd "$extracted_dir"
echo "$extracted_dir"
./configure
make
#make install


# Clean up
cd ..
#rm -rf "$extracted_dir"
#rm -f vim-latest.tar.gz


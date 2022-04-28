#!/usr/bin/env bash


if command -v tmux &> /dev/null; then
tmux_required="tmux 3.4-rc"
tmux_version=$(tmuxz -V 2> /dev/null | head -1)
highest_version=$(echo -e "${tmux_required}\n${tmux_version}" | sort -V | head -1)
echo "${highest_version}"
if [ "${highest_version}" != "${tmux_required}" ]; then
  echo "${tmux_required} needs installing"
else
	echo "${tmux_required} or newer available"
fi

exit

if [ "${EUID}" -ne 0 ]; then
	echo "run as root; i.e. sudo ./setup_tmux.sh"
	exit
fi

required=(libncurses5-dev libevent-dev)
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

set -e

if [ ${#missing[@]} -gt 0 ]; then
	echo "installing ${#missing[@]} packages..."
fi

for package in "${missing[@]}"; do
	apt --yes install "${package}"
done


rm -rf tmp
mkdir tmp
cd tmp

# Install tmux
wget "https://github.com/tmux/tmux/releases/download/3.3-rc/tmux-3.3-rc.tar.gz"
tar xvf "tmux-3.3-rc.tar.gz"
cd "tmux-3.3-rc"
./configure
make
make install
cd ..


cd ..
rm -rf tmp

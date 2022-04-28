#!/usr/bin/env bash

missing_packages=()
if ! command -v aclocal &> /dev/null; then
	missing_packages+=("autotools-dev")
	missing_packages+=("automake")
fi
if ! command -v libtoolize &> /dev/null; then missing_packages+=("libtool"); fi

if [ ${#missing_packages[@]} -gt 0 ]; then
	missing_packages=$(IFS=" " ; echo "${missing_packages[*]}")
	echo "missing packages... sudo apt install ${missing_packages}"
	exit
fi

exit

set -e

cd ${HOME}

# Clean up
rm -rf ncurses-6.3*
rm -rf libevent-2.1*
rm -rf tmux-3.3-rc*

# Install ncurses
wget "https://invisible-mirror.net/archives/ncurses/ncurses-6.3.tar.gz"
tar xvf "ncurses-6.3.tar.gz"
cd "ncurses-6.3"
./configure --prefix=${HOME}/.local
make
make install
cd ..

# Install libevent
wget "https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"
tar xvf "libevent-2.1.12-stable.tar.gz"
cd "libevent-2.1.12-stable"
./autogen.sh
./configure --prefix=${HOME}/.local
make
make install
cd ..

# Install tmux
wget "https://github.com/tmux/tmux/releases/download/3.3-rc/tmux-3.3-rc.tar.gz"
tar xvf "tmux-3.3-rc.tar.gz"
cd "tmux-3.3-rc"
./configure --prefix=${HOME}/.local \
    CFLAGS="-I${HOME}/.local/include -I${HOME}/.local/include/ncurses" \
    LDFLAGS="-L${HOME}/.local/include -L${HOME}/.local/include/ncurses -L${HOME}/.local/lib"
make
make install
cd ..


# Clean up
rm -rf ncurses-6.3*
rm -rf libevent-2.1*
rm -rf tmux-3.3-rc*

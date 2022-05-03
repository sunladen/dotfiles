#!/usr/bin/env bash

. ./base_update.sh

tarball_url=$(curl -sL https://api.github.com/repos/tmux/tmux/releases/latest | grep -Po '"browser_download_url":[ ]*"\K[^"]+')
tarball_version=$(basename "$tarball_url" | sed "s/\.tar\.gz//" | sed "s/-/ /")

compareInstalled "${tarball_version}" "tmux" "-V 2> /dev/null | head -1"

dependancies "libevent-dev"

#required=(libncurses5-dev libevent-dev)

downloadAndInstall "${tarball_url}"

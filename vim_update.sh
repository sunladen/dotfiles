#!/usr/bin/env bash

. ./base_update.sh

tarball_url=$(curl -sL https://api.github.com/repos/vim/vim/tags | grep -Po '"tarball_url":[ ]*"\K[^"]+' | head -1)
tarball_version=$(basename "$tarball_url")

compareInstalled "${tarball_version}" "vim" "--version | head -2 | sed \"N;s/\n/ /\" | sed -E \"s/^VIM - Vi IMproved (.*) \(.*Included patches: 1-([0-9]+).*$/v\1.\2/g\""

dependancies "build-essential" "libncurses-dev"

downloadAndInstall "${tarball_url}"

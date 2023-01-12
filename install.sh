#!/usr/bin/env bash

# shellcheck source=/dev/null
source helpers.sh

# Setup dotfiles and path variables from .profile
os_install stow
./symlink.sh || { exit 1; }

echo ''
echo 'Installing applications...'
bash --login -c "./post_install.sh"

echo ''
echo 'Running tests...'
bash --login -c "./test.sh"

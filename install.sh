#!/usr/bin/env bash

set -e # Fail the script if any installs fail

# shellcheck source=/dev/null
source helpers.sh

# Prepare ubuntu
if os_is ubuntu; then
	sudo apt update && sudo apt-get update && sudo apt upgrade
	os_install curl
	os_install locales
	sudo locale-gen en_AU.UTF-8
fi

# Install Homebrew
# https://brew.sh/
if have_not_installed brew; then
	NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install stow
# - We need to manually specify the paths because this happens before symlinking everything
if have_not_installed stow; then
	if os_is mac && chip_is intel; then
		/usr/local/bin/brew install stow
	fi
	if os_is mac && chip_is apple_silicon; then
		/opt/homebrew/bin/brew install stow
	fi
	if os_is ubuntu; then
		sudo apt-get install -y stow
	fi
fi

# Setup dotfiles and path variables from .profile
./symlink.sh || { exit 1; }

echo ''
echo 'Installing applications...'
bash --login -c "./post_install.sh"

echo ''
echo 'Running tests...'
bash --login -c "./test.sh"

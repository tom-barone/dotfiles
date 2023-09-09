#!/usr/bin/env bash

source helpers.sh

# Install Homebrew 
# https://brew.sh/
if have_not_installed brew; then
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install oh-my-zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "oh-my-zsh already installed"
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended --keep-zshrc
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

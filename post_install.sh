#!/usr/bin/env bash

set -e # Fail the script if any installs fail
source helpers.sh

# Essentials
os_install wget
if os_is ubuntu; then
	os_install build-essential # make and more
	os_install snapd
	os_install unzip
	os_install software-properties-common
fi
if os_is mac; then
	xcode-select --install || true
	os_install make
	os_install mono
fi

# Latest zsh
os_install zsh

# Python
# https://formulae.brew.sh/formula/python@3.11
os_install python3
if os_is ubuntu; then
	os_install python3-pip
fi

# .NET SDK and runtime
# Ignore for now, there were some issues running it
# on the github action ubuntu:22.04 runner image
#if os_is mac; then
## Pre-requisite
## https://learn.microsoft.com/en-us/dotnet/core/install/macos#libgdiplus
#os_install mono-libgdiplus
#fi
## https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
#if have_not_installed dotnet; then
#wget https://dot.net/v1/dotnet-install.sh
#chmod +x dotnet-install.sh
#./dotnet-install.sh --channel 7.0
#rm dotnet-install.sh
#fi

# Git credential manager
# https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md
if have_not_installed git-credential-manager; then
	if os_is mac; then
		brew install --cask git-credential-manager
	fi
	if os_is ubuntu; then
		wget "https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.3.2/gcm-linux_amd64.2.3.2.deb"
		sudo dpkg -i gcm-linux_amd64.2.3.2.deb
		rm gcm-linux_amd64.2.3.2.deb
	fi
fi

# zsh-abbr
# https://zsh-abbr.olets.dev/installation.html
git clone https://github.com/olets/zsh-abbr --single-branch --branch main --depth 1 "$HOME/opt/zsh-abbr"

# Powerlevel10k
# https://github.com/romkatv/powerlevel10k#installation
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/opt/powerlevel10k"

# Fzf
# https://github.com/junegunn/fzf/
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/opt/fzf"
"$HOME/opt/fzf/install" --bin --no-update-rc

# ZSH extra completions
# https://github.com/zsh-users/zsh-completions
git clone --depth 1 https://github.com/zsh-users/zsh-completions.git "$HOME/opt/zsh-completions"

# GNU versions of important programs
if os_is mac; then
	# Don't want to check if they're already installed
	brew install gnu-sed
	brew install make
fi

os_install cmake
os_install vim
os_install tmux
os_install shellcheck
os_install shfmt
os_install tig

# Ruby and rbenv
# https://github.com/rbenv/rbenv
default_ruby_version=2.7.3
os_install rbenv
if os_is mac; then
	os_install ruby-build
fi
rbenv install --skip-existing $default_ruby_version
rbenv global $default_ruby_version

# Gems
gem_install tmuxinator # https://github.com/tmuxinator/tmuxinator
# TODO: Add back in and tests
#gem_install rubocop
#gem_install neovim
#gem_install htmlbeautifier

# Node (version 18 is LTS)
# https://nodejs.org/en/download/package-manager
if os_is mac; then
	os_install node
fi
if os_is ubuntu; then
	sudo snap install node --classic --channel=18
fi

# Neovim setup
# TODO: Add python, ruby and node setup
#os_install neovim

## cargo
#if have_not_installed cargo; then
#curl https://sh.rustup.rs -ssf | bash -s -- -y --no-modify-path
#source "$HOME/.cargo/env"
#fi

## ripgrep
#if have_not_installed rg; then
#cargo install ripgrep
#fi

## Python stuff
#pip3 install virtualenvwrapper

#pip_install yapf
#pip_install prospector
#pip_install poetry

## Gcloud
#gcloud_sdk_url=''
#if os_is mac; then
## macOS 64-bit https://cloud.google.com/sdk/docs/install#mac
#gcloud_sdk_url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-319.0.0-linux-x86_64.tar.gz"
#fi
#if os_is ubuntu; then
## Linux 64-bit https://cloud.google.com/sdk/docs/quickstart#linux
#gcloud_sdk_url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-319.0.0-darwin-x86_64.tar.gz"
#fi
#if have_not_installed gcloud; then
## Download the install tar.gz
#wget $gcloud_sdk_url -O cloud-sdk.tar.gz
## Extract it to the home dir
#tar -xvf cloud-sdk.tar.gz -C ~
## Run the install script
#~/google-cloud-sdk/install.sh --usage-reporting=false --command-completion=false --path-update=false
## Remove the install tar.gz
#rm cloud-sdk.tar.gz
#fi

## NVM
## Need to do this install check because the other doesn't work for some reason
#if ! [ -s "$NVM_DIR/nvm.sh" ]; then
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.1/install.sh | bash
#\. "$HOME/.nvm/nvm.sh"

## Node
#nvm install --lts
#nvm install-latest-npm
#nvm use --lts
#nvm alias default lts/*
#fi

## NPM stuff
#npm_global_install prettier
#npm_global_install neovim

## Android platform tools
## https://developer.android.com/studio/releases/platform-tools
#android_sdk=""
#if os_is mac; then
#android_sdk="https://dl.google.com/android/repository/platform-tools-latest-darwin.zip"
#fi
#if os_is ubuntu; then
#android_sdk="https://dl.google.com/android/repository/platform-tools-latest-linux.zip"
#fi
#if have_not_installed adb; then
#wget $android_sdk -O android-sdk.zip
#unzip android-sdk.zip -d ~
#rm android-sdk.zip
#fi

## Java
#if os_is ubuntu; then
#if have_not_installed java; then
#os_install default-jre
#fi
#fi

## Google Cloud SQL proxy
#proxy_file_url=""
#if os_is mac; then
#proxy_file_url="https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64"
#fi
#if os_is ubuntu; then
#proxy_file_url="https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64"
#fi
#if have_not_installed cloud_sql_proxy; then
#curl -o /usr/local/bin/cloud_sql_proxy $proxy_file_url
#chmod +x /usr/local/bin/cloud_sql_proxy
#fi

## TODO see if we can remove duplicated code between here and bashrc
#export WORKON_HOME=~/.virtualenvs
#if os_is mac; then
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.9
#source /usr/local/bin/virtualenvwrapper.sh
#fi
#if os_is ubuntu; then
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.9
#source ~/.local/bin/virtualenvwrapper.sh
#fi

## Setup python3 in nvim
#mkvirtualenv nvim
#pip3 install neovim
#pip3 install pynvim
#deactivate

#os_install neofetch

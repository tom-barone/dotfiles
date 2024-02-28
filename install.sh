#!/usr/bin/env bash

set -e # Fail the script if any installs fail
set -x # Print each command as it runs

# shellcheck source=/dev/null
source helpers.sh

# Prepare ubuntu
if os_is ubuntu; then
	sudo apt update
	sudo apt-get update
	sudo apt -y upgrade
	sudo apt-get -y upgrade
	os_install curl
	os_install locales
	sudo locale-gen en_AU.UTF-8
fi

# Install Homebrew
# https://brew.sh/
if have_not_installed brew; then
	NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install stow and python
# - We need to manually specify the paths because this happens before symlinking everything
# - We want our proper python setup before doing pip installs
# https://www.gnu.org/software/stow/
# https://formulae.brew.sh/formula/python@3.11

python_versions=(python@3 python@3.12 python@3.11 python@3.9)

if os_is mac && chip_is intel; then
	/usr/local/bin/brew install "${python_versions[@]}" stow || true

	# Fix linking issues on the github actions macos runner
	/usr/local/bin/brew update --force || true
	/usr/local/bin/brew link --overwrite "${python_versions[@]}"

	# Fix issues with node.js and icu4c on the Github Actions macos runner
	/usr/local/bin/brew uninstall --ignore-dependencies --force node icu4c 
	/usr/local/bin/brew install node

	# Make brew and stow available when symlinking
	export PATH="/usr/local/bin:$PATH"
fi
if os_is mac && chip_is apple_silicon; then
	/opt/homebrew/bin/brew install "${python_versions[@]}" stow

	# Make brew and stow available when symlinking
	export PATH="/opt/homebrew/bin:$PATH"
	sudo ln -s /opt/homebrew/bin/python3 /opt/homebrew/bin/python
fi
if os_is ubuntu; then
	/home/linuxbrew/.linuxbrew/bin/brew install "${python_versions[@]}"
	sudo apt-get install -y stow
fi

# Create ~/opt directory so that symlinking doesn't
# put the cloned git repos in our dotfiles repo
mkdir -p "$HOME/opt"

# Setup dotfiles and path variables from .profile
./symlink.sh || { exit 1; }

echo ''
echo 'Installing applications...'
bash --login -ic "./post_install.sh"

echo ''
echo 'Running tests...'
bash --login -ic "./test.sh"

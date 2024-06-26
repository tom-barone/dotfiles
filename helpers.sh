#!/usr/bin/env bash

# If a .env file exists, load it
if [ -f .env ]; then
	# shellcheck source=/dev/null
	source .env
fi

function os_is() {
	uname="$(uname -a)"

	[[ "$1" == 'mac' ]] && [[ "$uname" =~ Darwin ]] && return

	# Ubuntu
	[[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ Ubuntu ]] && return
	[[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ GNU/Linux ]] && return # For macOS docker & WSL2

	# For WSL2 on windows using ubuntu
	[[ "$1" == 'wsl-ubuntu' ]] && [[ "$uname" =~ GNU/Linux ]] && [[ "$uname" =~ WSL2 ]] && return

	false
}

function ubuntu_release_number_is() {
	ubuntu_release="$(grep DISTRIB_RELEASE /etc/lsb-release | cut -d '=' -f 2)"
	[[ "$1" == "$ubuntu_release" ]] && return
	false
}

function chip_is() {
	uname="$(uname -m)"

	[[ "$1" == 'apple_silicon' ]] && [[ "$uname" =~ arm ]] && return
	[[ "$1" == 'arm' ]] && [[ "$uname" =~ arm ]] && return
	[[ "$1" == 'intel' ]] && [[ "$uname" =~ x86 ]] && return
	[[ "$1" == 'x86' ]] && [[ "$uname" =~ x86 ]] && return

	false
}

function have_not_installed() {
	if ! command -v "$1" &>/dev/null; then
		return
	fi

	echo "$1 already installed"
	false
}

if os_is mac; then
	export PACKAGE_INSTALLER="brew install"
fi
if os_is ubuntu; then
	PACKAGE_INSTALLER="sudo apt install -y"
	#sudo apt-get update
fi

function os_install() {
	if have_not_installed "$1"; then
		$PACKAGE_INSTALLER "$1"
	fi
}

function brew_install() {
	brew install "$1"
}

function brew_cask_install() {
	brew install --cask "$1"
}

function pipx_install() {
	if have_not_installed "$1"; then
		pipx install "$1"
	fi
}

function npm_global_install() {
	if have_not_installed "$1"; then
		npm install --global "$1"
	fi
}

function gem_install() {
	gem install "$1"
}

function cargo_install() {
	if have_not_installed "$1"; then
		cargo install "$1"
	fi
}

################################################################################
# Install a go package if it hasn't been installed yet.
# Arguments:
# 	$1: The name of the package to install.
# 		Example: gopls
# 	$2: The path to the package to install.
# 		Example: golang.org/x/tools/gopls@latest
################################################################################
function go_install() {
	if have_not_installed "$1"; then
		go install "$2"
	fi
}

function check_environment_variable() {
	if [[ -z "${!1}" ]]; then
		echo "ERROR: variable $1 not set"
		exit 1
	fi
}

function no_directory_exists_at() {
	if [[ ! -d "$1" ]]; then
		return
	fi

	echo "$1 already exists"
	false
}

# Returns true if the current environment is a CI environment.
function ci {
	if [[ "$CI" = true ]]; then
		return
	fi
	false
}

# Returns true if the current environment is not a CI environment.
function not_ci {
	if ! ci; then
		return
	fi
	false
}

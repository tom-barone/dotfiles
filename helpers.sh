#!/usr/bin/env bash

function os_is() {
	uname="$(uname -a)"

	[[ "$1" == 'mac' ]] && [[ "$uname" =~ Darwin ]] && return
	[[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ Ubuntu ]] && return

	# For WSL2 on windows using ubuntu
	[[ "$1" == 'wsl-ubuntu' ]] && [[ "$uname" =~ GNU/Linux ]] && [[ "$uname" =~ WSL2 ]] && return

	# For the macOS version of dockerized ubuntu...
	[[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ GNU/Linux ]] && return

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
	[[ "$1" == 'ARM' ]] && [[ "$uname" =~ arm ]] && return
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
	if have_not_installed "$1"; then
		brew install "$1"
	fi
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
	if have_not_installed "$1"; then
		gem install "$1"
	fi
}

function cargo_install() {
	if have_not_installed "$1"; then
		cargo install "$1"
	fi
}

function no_directory_exists_at() {
	if [[ ! -d "$1" ]]; then
		return
	fi

	echo "$1 already exists"
	false
}

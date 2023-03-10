#!/usr/bin/env bash

function os_is() {
	uname="$(uname -a)"

	[[ "$1" == 'mac' ]] && [[ "$uname" =~ Darwin ]] && return
	[[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ Ubuntu ]] && return

	# For the macOS version of dockerized ubuntu...
	[[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ GNU/Linux ]] && return

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
	PACKAGE_INSTALLER="sudo apt-get install -y"
	#sudo apt-get update
fi

function os_install() {
	if have_not_installed "$1"; then
		$PACKAGE_INSTALLER "$1"
	fi
}

function pip_install() {
	if have_not_installed "$1"; then
		pip3 install --user "$1"
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

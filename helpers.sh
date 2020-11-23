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
    if ! command -v "$1" &> /dev/null; then
        return
    fi

    echo "$1 already installed"
    false
}

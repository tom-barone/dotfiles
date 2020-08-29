function os_is() {
    uname="$(uname -a)"

    [[ "$1" == 'mac' ]] && [[ "$uname" =~ Darwin ]] && return
    [[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ Ubuntu ]] && return

    false
}

function have_not_installed() {
    if ! command -v $1 &> /dev/null; then
        return
    fi

    echo "$1 already installed"
    false
}

function os_is() {
    uname="$(uname -a)"

    [[ "$1" == 'mac' ]] && [[ "$uname" =~ Darwin ]] && return
    [[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ Ubuntu ]] && return

    false
}

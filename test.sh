#!/usr/bin/env bash

function test() {
    if $1 >/dev/null 2>&1; then
        echo "Pass: \"$1\""
        return
    else
        echo "Failed: \"$1\""
        $1
        exit 1
    fi
}

test 'vim --version'
test 'tig --version'
test 'nvim --version'
test 'tmux -V'
test 'fzf --version'
test 'cargo --version'
test 'rg --version'
test 'rbenv --version'
test 'ruby --version'
test 'gem --version'
test 'tmuxinator version'
test 'shellcheck --version'
test 'shfmt --version'
test 'gvm version'
test 'go version'
test 'yapf --version'
test 'prospector --version'

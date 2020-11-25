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

test 'cargo --version'
test 'fzf --version'
test 'gcloud --version'
test 'gem --version'
test 'go version'
test 'gvm version'
test 'nvim --version'
test 'poetry --version'
test 'prettier --version'
test 'prospector --version'
test 'rbenv --version'
test 'rg --version'
test 'ruby --version'
test 'rubocop --version'
test 'shellcheck --version'
test 'shfmt --version'
test 'tig --version'
test 'tmux -V'
test 'tmuxinator version'
test 'vim --version'
test 'yapf --version'

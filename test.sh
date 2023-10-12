#!/usr/bin/env bash

# NOTE: Makes use of the global environment variable
# HAS_TEST_SUITE_PASSED to determine if the test suite
# has passed or not. This is set to true at the start
# of the test suite and set to false if any test fails.

source helpers.sh
source test_functions.sh

export HAS_TEST_SUITE_PASSED=true

# Essentials
assert_success 'curl --version'
assert_success 'wget --version'
assert_success 'cmake --version'
assert_success 'git --version'
assert_success 'zsh --version'
assert_success 'brew --version'
assert_success 'stow --version'

# Python and python package managers
assert_success 'python3 --version'
assert_success 'pip3 --version'
assert_success 'pipx --version'
assert_success 'poetry --version'

# Check that we're using the homebrew version of zsh (not /bin/zsh)
assert_result_like 'which zsh' "$(brew --prefix)/bin/zsh"

if os_is mac; then
	# Check that python and pip are installed in the right place
	assert_result_like 'which python3' "$(brew --prefix)/bin/python3"
	assert_result_like 'which pip3' "$(brew --prefix)/bin/pip3"
	# Check our laassert_success GNU overrides are working on mac
	assert_result_like 'which make' "$(brew --prefix)/opt/make/libexec/gnubin/make"
	assert_result_like 'which sed' "$(brew --prefix)/opt/gnu-sed/libexec/gnubin/sed"
	# Check that tmux-256color is installed
	assert_success 'infocmp -x tmux-256color'
fi

assert_success 'git-credential-manager --version'
assert_success_zsh 'abbr --version'
assert_success_zsh 'p10k help'
assert_success_zsh 'fzf --version'
assert_zsh_completion 'tar'   # Default that comes with zsh
assert_zsh_completion 'git'   # Default that comes with zsh
assert_zsh_completion 'rails' # Comes installed with zsh-completions

# Node
assert_success 'node --version'
assert_success 'npm --version'

# Rust
assert_success 'rustup --version'
assert_success 'cargo --version'

# Ruby and rbenv
eval "$(rbenv init - bash)"
assert_success 'rbenv --version'
assert_result_like 'ruby --version' "3.1.4"

# Terminal handy tools
assert_success 'vim --version'
assert_success 'tmux -V'
assert_success 'tig --version'
assert_success 'exa --version'
assert_success 'bat --version'
assert_success 'rg --version'
assert_success 'type neofetch'
assert_success 'tmuxinator version'
assert_success 'perl --version'
assert_success 'cpanm --version'
assert_result_like 'which perl' "$(brew --prefix)/bin/perl"   # We want the homebrew
assert_result_like 'which cpanm' "$(brew --prefix)/bin/cpanm" # perl and cpanm

# Language servers
assert_success 'lua-language-server --version'
assert_success 'shellcheck --version'
assert_success 'bash-language-server --version'
assert_success 'type vim-language-server'
assert_success 'tsc --version'
assert_success 'typescript-language-server --version'
assert_success 'type vscode-html-language-server'
assert_success 'type vscode-css-language-server'
assert_success 'type vscode-json-language-server'
assert_success 'type vscode-eslint-language-server'
assert_success 'pylsp --version'
assert_success 'solargraph --version'
assert_success 'yard --version'
assert_success 'which vscode-html-language-server'
assert_success 'which vscode-css-language-server'
assert_success 'which vscode-json-language-server'

# Formatters and linters
assert_success 'shfmt --version'
assert_success 'prettier --version'
assert_success 'black --version'
assert_success 'prospector --version'
assert_success 'rubocop --version'
assert_success 'sqlformat --version'
assert_success 'htmlbeautifier --version'

# Neovim
assert_success 'nvim --version'
assert_success_zsh 'mkvirtualenv --help'

# Redis
assert_success 'redis-cli --version'
assert_result_like 'redis-cli PING' 'PONG'

# Global ruby gems
assert_success 'rails --version'

# AWS
assert_success 'cdk --version'

#assert_success 'adb --version'
#assert_success 'cargo --version'
#assert_success 'cloud_sql_proxy --version'
#assert_success 'fastboot --version'
#assert_success 'fzf --version'
#assert_success 'gcloud --version'
#assert_success 'gem --version'
#assert_success 'go version'
#assert_success 'gvm version'
#assert_success 'htmlbeautifier -h'
## Doesn't work on mac, need to use "java -showversion"
##assert_success 'java --version'
#assert_success 'nvim --version'
#assert_success 'node --version'
#assert_success 'npm --version'
#assert_success 'poetry --version'
#assert_success 'prettier --version'
#assert_success 'prospector --version'
#assert_success 'rbenv --version'
#assert_success 'rg --version'
#assert_success 'ruby --version'
#assert_success 'rubocop --version'
#assert_success 'shellcheck --version'
#assert_success 'shfmt --version'
#assert_success 'tig --version'
#assert_success 'tmux -V'
#assert_success 'tmuxinator version'
#assert_success 'vim --version'
#assert_success 'yapf --version'
#
#

# Check that git config is set correctly
(cd ~/code && assert_result_like 'git config user.email' 'tbarone@comunet.com.au')
(cd ~/dotfiles && assert_result_like 'git config user.email' 'mail@tombarone.net')

assert_no_git_changes

if [ $HAS_TEST_SUITE_PASSED == false ]; then
	printf "\nTests failed\n"
	exit 1
else
	printf "\nTests passed\n"
fi

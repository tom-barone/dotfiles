#!/usr/bin/env bash

# NOTE: Makes use of an environment variable
# HAS_TEST_SUITE_PASSED to determine if the test suite
# has passed or not.
# - It is set to true at the start of the test suite
# - It is set to false if any test fails.
# - It is checked at the end to determine what return code to exit with.

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
if os_is wsl-ubuntu; then
	assert_success 'wslview --version'
fi

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
assert_success 'git-lfs --version'

assert_success_zsh 'abbr --version'
assert_success_zsh 'p10k help'
assert_success_zsh 'fzf --version'
assert_zsh_completion 'tar'   # Default that comes with zsh
assert_zsh_completion 'git'   # Default that comes with zsh
assert_zsh_completion 'rails' # Comes installed with zsh-completions
assert_success 'go version'

# Node
assert_success 'node --version'
assert_success 'npm --version'

# Yarn
assert_success 'corepack --version'
assert_success 'yarn --version'

# Rust
assert_success 'rustup --version'
assert_success 'cargo --version'

# Java
assert_success 'java --version'

# Ruby and rbenv
eval "$(rbenv init - bash)"
assert_success 'rbenv --version'
assert_success 'ruby --version'

# Terminal handy tools
assert_success 'vim --version'
assert_success 'tmux -V'
assert_success 'tig --version'
assert_success 'eza --version'
assert_success 'bat --version'
assert_success 'rg --version'
assert_success 'tmuxinator version'
assert_success 'perl --version'
assert_success 'cpanm --version'
assert_result_like 'which perl' "$(brew --prefix)/bin/perl"   # We want the homebrew
assert_result_like 'which cpanm' "$(brew --prefix)/bin/cpanm" # perl and cpanm
assert_success 'dua --version'
assert_success 'just --version'
assert_success 'flamegraph --version'
assert_success 'jq --version'
assert_success 'watchman --version'
assert_success 'lychee --version'
assert_success 'btm --version'

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
assert_success 'yard --version'
assert_success 'which vscode-html-language-server'
assert_success 'which vscode-css-language-server'
assert_success 'which vscode-json-language-server'
assert_success 'gopls version'
assert_success 'rust-analyzer --version'
assert_success 'svelteserver'
assert_success 'npm list --global | grep svelte-language-server'

# Formatters and linters
assert_success 'shfmt --version'
assert_success 'prettier --version'
assert_success 'ruff --version'
assert_success 'isort --version'
assert_success 'pyright --version'
assert_success 'rubocop --version'
assert_success 'eslint --version'
assert_success 'erb-format --version'
assert_success 'sqlformat --version'
assert_success 'djlint --version'
assert_success 'stylua --version'

# Neovim
assert_success 'nvim --version'

# Redis
assert_success 'redis-cli --version'
assert_result_like 'redis-cli PING' 'PONG'

# AWS
assert_success 'aws --version'
assert_success 'cdk --version'

# Heroku
assert_success 'heroku --version'

# Github
assert_success 'gh --version'

# Android tools
assert_success 'adb --version'
assert_success 'fastboot --version'
assert_file_exists "$HOME/platform-tools/bundletool.jar"

# Gstreamer
assert_success 'gst-inspect-1.0 --version'

# Supervisord
assert_success 'supervisord --version'

# Cloud SQL proxy
assert_success 'cloud_sql_proxy --version'

# Mysql
assert_success 'mysql --version'

# Gcloud
assert_success 'gcloud --version'

# Global ruby gems
assert_success 'rails --version'

# Langauge / AI stuff
assert_success 'sdl2-config --version'
assert_success 'ffmpeg -version'

# Stuff we want to check for but
# but don't want to run in CI
if not_ci; then
	assert_success 'docker --version'
	assert_success 'gh copilot --version'

	if os_is mac && chip_is apple_silicon; then
		assert_success 'pod --version' # CocoaPods
		assert_success 'flutter --version'
	fi
fi

# Print out some useful info during the CI build
if [ "$DEBUG_INFO" == true ]; then
	echo "Current directory: $(pwd)"
	echo "Home directory: $(ls ~)"
	echo "PATH = $PATH"
	ls -al /usr/local/bin
fi

# Check that git config is set correctly
# If the code directory exists
if [ -d ~/code ]; then
	# Check that the git config is set correctly
	(cd ~/code && assert_result_like 'git config user.email' 'tbarone@comunet.com.au')
fi
(cd ~/dotfiles && assert_result_like 'git config user.email' 'mail@tombarone.net')

assert_no_git_changes

if [ $HAS_TEST_SUITE_PASSED == false ]; then
	printf "\n\e[1;31mTests failed\e[0m\n"
	exit 1
else
	printf "\n\e[1;32mTests passed\e[0m\n"
fi

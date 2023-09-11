#!/usr/bin/env bash

source helpers.sh

export HAS_TEST_SUITE_PASSED=true
function test() {
	# shellcheck disable=SC2086
	if eval $1 >/dev/null 2>&1; then
		echo "Pass: \"$1\""
		return
	else
		echo "Failed: \"$1\""
		$1
		export HAS_TEST_SUITE_PASSED=false
	fi
}

function check() {
	output=$(zsh --interactive --login -c "$1") # run in zsh
	if [[ $output == *"$2"* ]]; then
		echo "Pass: \"$1\""
		return
	else
		echo "Failed: \"$1\""
		echo "Expected \"$2\""
		echo "Got \"$output\""
		export HAS_TEST_SUITE_PASSED=false
	fi
}

function has_zsh_completion() {
	# Store the old seperator and replace it later
	zsh_fpath=$(zsh --interactive --login -c 'echo $FPATH')
	oldIFS=$IFS
	IFS=:
	found=false                   # Flag for if we find the completion file
	for dir in $zsh_fpath; do     # For each directory in $FPATH
		if [[ -e "$dir/_$1" ]]; then # If the completion file exists
			echo "Pass: \"$1\""
			found=true # Set our flag to true
			return
		fi
	done
	IFS=$oldIFS

	if [[ $found == false ]]; then
		echo "Failed: \"$1\"" # If we didn't find any completion file...
		export HAS_TEST_SUITE_PASSED=false
	fi
}

# Essentials
test 'curl --version'
test 'wget --version'
test 'cmake --version'
test 'git --version'
test 'zsh --version'
test 'brew --version'
test 'stow --version'

test 'python3 --version'
test 'pip3 --version'
# Check that we're using the homebrew version of zsh (not /bin/zsh)
check 'which zsh' "$(brew --prefix)/bin/zsh"

if os_is mac; then
	# Check that python and pip are installed in the right place
	check 'which python3' "$(brew --prefix)/bin/python3"
	check 'which pip3' "$(brew --prefix)/bin/pip3"

	# Check our latest GNU overrides are working on mac
	check 'which make' "$(brew --prefix)/opt/make/libexec/gnubin/make"
	check 'which sed' "$(brew --prefix)/opt/gnu-sed/libexec/gnubin/sed"
fi

test 'git-credential-manager --version'
test 'zsh --interactive --login -c "abbr --version"'
test 'zsh --interactive --login -c  "p10k help"'
test 'zsh --interactive --login -c "fzf --version"'
has_zsh_completion 'tar'   # Default that comes with zsh
has_zsh_completion 'git'   # Default that comes with zsh
has_zsh_completion 'rails' # Comes installed with zsh-completions

test 'node --version'
test 'npm --version'

test 'rustup --version'
test 'cargo --version'

test 'vim --version'
test 'tmux -V'
test 'tig --version'
test 'exa --version'
test 'bat --version'
test 'rg --version'
test 'type neofetch'

test 'lua-language-server --version'
test 'shellcheck --version'
test 'shfmt --version'
test 'bash-language-server --version'
test 'type vim-language-server'

test 'nvim --version'
test 'zsh --interactive --login -c "mkvirtualenv --help"'

#test 'adb --version'
#test 'cargo --version'
#test 'cloud_sql_proxy --version'
#test 'fastboot --version'
#test 'fzf --version'
#test 'gcloud --version'
#test 'gem --version'
#test 'go version'
#test 'gvm version'
#test 'htmlbeautifier -h'
## Doesn't work on mac, need to use "java -showversion"
##test 'java --version'
#test 'nvim --version'
#test 'node --version'
#test 'npm --version'
#test 'poetry --version'
#test 'prettier --version'
#test 'prospector --version'
#test 'rbenv --version'
#test 'rg --version'
#test 'ruby --version'
#test 'rubocop --version'
#test 'shellcheck --version'
#test 'shfmt --version'
#test 'tig --version'
#test 'tmux -V'
#test 'tmuxinator version'
#test 'vim --version'
#test 'yapf --version'
#
#

## Ruby and rbenv
## Run last so it can be commented out easily
#test 'rbenv --version'
#check 'ruby --version' "3.1.2"

## Gems
#test 'tmuxinator version'

if [ $HAS_TEST_SUITE_PASSED == false ]; then
	printf "\nTests failed\n"
	exit 1
else
	printf "\nTests passed\n"
fi

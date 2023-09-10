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
	# Run the check in zsh
	output=$(zsh -ic "$1")
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

# Essentials
test 'curl --version'
test 'wget --version'
test 'git --version'
test 'zsh --version'
test 'brew --version'
test 'stow --version'

test 'python3 --version'
test 'pip3 --version'
if os_is mac; then
	# Check that python and pip are installed in the right place
	check 'which python3' "$(brew --prefix)/bin/python3"
	check 'which pip3' "$(brew --prefix)/bin/pip3"

	# Check our latest GNU overrides are working on mac
	check 'which make' "$(brew --prefix)/opt/make/libexec/gnubin/make"
	check 'which sed' "$(brew --prefix)/opt/gnu-sed/libexec/gnubin/sed"
fi

test 'git-credential-manager --version'
test 'zsh -ic "abbr --version"'
test 'zsh -ic "p10k help"'
test 'zsh -ic "fzf --version"'
test 'cmake --version'
test 'vim --version'
test 'tmux -V'
test 'shellcheck --version'
test 'shfmt --version'
test 'tig --version'

# Ruby and rbenv
test 'rbenv --version'
test 'ruby --version'

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

if [ $HAS_TEST_SUITE_PASSED == false ]; then
	printf "\nTests failed\n"
	exit 1
else
	printf "\nTests passed\n"
fi

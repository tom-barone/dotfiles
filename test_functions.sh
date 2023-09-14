#!/usr/bin/env bash

function assert_success() {
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

function assert_success_zsh() {
	assert_success "zsh --interactive --login -c \"$1\""
}

function assert_result_like() {
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

function assert_zsh_completion() {
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

function assert_no_git_changes() {
	# Check if there are any git changes or new untracked files
	git status
	git add .
	if git diff-index --quiet HEAD; then
		echo "Pass: No git changes"
	else
		echo "Failed: There are git changes"
		export HAS_TEST_SUITE_PASSED=false
	fi
}

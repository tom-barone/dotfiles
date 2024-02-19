#!/usr/bin/env bash

pass="\e[1;32mPass\e[0m"     # Print in green
failed="\e[1;31mFailed\e[0m" # Print in red

################################################################################
# Assert that the command passed in succeeds.
# When the command succeeds, it will print "Pass: \"$1\""
# When the command fails, it will print "Failed: \"$1\"" and set
# HAS_TEST_SUITE_PASSED to false.
# It will also print why the command failed.
# Globals:
# 	HAS_TEST_SUITE_PASSED
# Arguments:
# 	$1: The command to run
################################################################################
function assert_success() {
	# shellcheck disable=SC2086
	if eval $1 >/dev/null 2>&1; then
		echo -e "$pass: $1"
		return
	else
		echo -e "$failed: $1"
		$1
		export HAS_TEST_SUITE_PASSED=false
	fi
}

################################################################################
# The same as `assert_success` but runs the command in a zsh login shell
# 	HAS_TEST_SUITE_PASSED
# Arguments:
# 	$1: The command to run
################################################################################
function assert_success_zsh() {
	assert_success "zsh --interactive --login -c \"$1\""
}

################################################################################
# Assert that the result of a command partially matches a string.
# e.g. assert_result_like 'ruby --version' "3.1.2"
# When the command succeeds, it will print "Pass: \"$1\""
# When the command fails, it will set HAS_TEST_SUITE_PASSED to false and
# print the expected and actual results.
# Globals:
# 	HAS_TEST_SUITE_PASSED
# Arguments:
# 	$1: The command to run
################################################################################
function assert_result_like() {
	output=$(zsh --interactive --login -c "$1") # run in zsh
	if [[ $output == *"$2"* ]]; then
		echo -e "$pass: $1"
		return
	else
		echo -e "$failed: $1"
		echo "Expected \"$2\""
		echo "Got \"$output\""
		export HAS_TEST_SUITE_PASSED=false
	fi
}

################################################################################
# Assert that a zsh completion file exists for the command passed in.
# e.g. assert_zsh_completion 'tar'
# When the completion file exists, it will print "Pass: $1"
# When the completion file doesn't exist, it will print "Failed: $1" and set
# HAS_TEST_SUITE_PASSED to false.
# Globals:
# 	HAS_TEST_SUITE_PASSED
# Arguments:
# 	$1: The command to check
################################################################################
function assert_zsh_completion() {
	# Store the old seperator and replace it later
	zsh_fpath=$(zsh --interactive --login -c 'echo $FPATH')
	oldIFS=$IFS
	IFS=:
	found=false                   # Flag for if we find the completion file
	for dir in $zsh_fpath; do     # For each directory in $FPATH
		if [[ -e "$dir/_$1" ]]; then # If the completion file exists
			echo -e "$pass: $1"
			found=true # Set our flag to true
			return
		fi
	done
	IFS=$oldIFS

	if [[ $found == false ]]; then
		echo -e "$failed: $1" # If we didn't find any completion file...
		export HAS_TEST_SUITE_PASSED=false
	fi
}

################################################################################
# Asserts that there are no git changes or new untracked files.
# When there are no changes, it will print "Pass: No git changes"
# When there are changes, it will print "Failed: There are git changes" and set
# HAS_TEST_SUITE_PASSED to false.
# Globals:
# 	HAS_TEST_SUITE_PASSED
################################################################################
function assert_no_git_changes() {
	# Check if there are any git changes or new untracked files
	git status
	git add .
	if git diff-index --quiet HEAD; then
		echo -e "$pass: No git changes"
	else
		echo -e "$failed: There are git changes"
		export HAS_TEST_SUITE_PASSED=false
	fi
}

#
# NOTE: All the local variables are included in normal shells
# like `homebrew_linux`, even though they are not exported
#

export EDITOR='nvim'
export LANG=en_AU.UTF-8
export LC_CTYPE=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
export TZ="Australia/Adelaide"

add_to_path() {
	[ -d "$1" ] && PATH="$1:$PATH"
}

add_to_fpath() {
	[ -d "$1" ] && FPATH="$1:$FPATH"
}

add_to_path "/opt/homebrew/bin"
add_to_path "/opt/homebrew/sbin"
add_to_path "/usr/local/bin"
add_to_path "/usr/local/sbin"
add_to_path "/home/linuxbrew/.linuxbrew/bin"
add_to_path "/home/linuxbrew/.linuxbrew/sbin"
add_to_path "$HOME/.dotnet"
add_to_path "$HOME/.dotnet/tools"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.config/composer/vendor/bin"
add_to_path "$HOME/.pub-cache/bin"
add_to_path "$HOME/platform-tools"
add_to_path "$HOME/google-cloud-sdk/bin"
add_to_path "$HOME/opt/go/bin"
add_to_path "$HOME/opt/gopath/bin"
add_to_path "$HOME/flutter/bin"
add_to_path "$HOME/opt/nvim/bin"
add_to_path "$HOME/opt/mac"
add_to_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
add_to_path "/Applications/Postgres.app/Contents/Versions/latest/bin"
add_to_path "/opt/mssql-tools18/bin"
add_to_path "$HOME/Library/Android/sdk/emulator"

if type brew &>/dev/null; then
	homebrew_prefix="$(brew --prefix)"
	export SHELL="$homebrew_prefix/bin/zsh"

	add_to_path "$homebrew_prefix/opt/make/libexec/gnubin"
	add_to_path "$homebrew_prefix/opt/gnu-sed/libexec/gnubin"
	add_to_path "$homebrew_prefix/opt/mysql@8.4/bin"

	add_to_fpath "$HOME/opt/zsh-completions/src"
	add_to_fpath "$homebrew_prefix/share/zsh/site-functions"
	add_to_fpath "$homebrew_prefix/share/zsh/functions"
	add_to_fpath "/usr/share/zsh/vendor-completions"
	
	export FPATH
fi

export PATH

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Dotnet variables
# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script#set-environment-variables
export DOTNET_ROOT=$HOME/.dotnet

# Rust
# shellcheck source=/dev/null
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
if type python3 &>/dev/null; then
	python_3_location="$(which python3)"
	export VIRTUALENVWRAPPER_PYTHON=$python_3_location
fi
if type virtualenvwrapper.sh &>/dev/null; then
	# shellcheck source=/dev/null
	source virtualenvwrapper.sh
fi

# FZF
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!.git/"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/"'

# Better `less` options
# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
export PAGER='less'
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

## Golang paths
export GOPATH="$HOME/opt/gopath"

## Python
# Set the Python cache directory to a custom location so
# it doesn't spam us with __pycache__ folders in our projects
export PYTHONPYCACHEPREFIX="$HOME/.cache/python"
export RUFF_CACHE_DIR="$HOME/.cache/ruff"

## Path for poetry
#export PATH="$HOME/.local/bin:$PATH"

## Path for azcopy
#export PATH="$HOME/bin:$PATH"

## Path for adb
#export PATH="$HOME/platform-tools:$PATH"

#export PATH="/usr/local/sbin:$PATH"
#export PATH="/usr/local/bin:$PATH"

## macOS
# I want gnu-sed not the weird macOS sec
# I want gmake not whatever Xcode uses
#export PATH="/usr/local/opt/make/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# Android development
if [[ $(uname -a) =~ "Darwin" ]]; then
	export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
	export ANDROID_HOME="$HOME/Library/Android/sdk"
	# shellcheck disable=SC2086,SC2155
	export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)" #
fi

## WSL ubuntu
if [[ $(uname -a) == *"WSL2"* ]]; then
	export BROWSER=wslview
	export GIT_CONFIG_GLOBAL="$HOME/git-configs/wsl-ubuntu/.gitconfig"
else
	# Mac
	export GIT_CONFIG_GLOBAL="$HOME/git-configs/mac/.gitconfig"
fi

## Want this alias in all shells (bash, zsh, sh)
#alias google-chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

## GPG
export GPG_TTY=$(tty)

## Deno environment
. "/Users/tbone/.deno/env"

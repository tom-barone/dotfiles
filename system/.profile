#
# NOTE: All the local variables are included in normal shells
# like `homebrew_linux`, even though they are not exported
#

export EDITOR='nvim'
export LANG=en_AU.UTF-8
export LC_CTYPE=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
#export TZ="Europe/Rome"
export TZ="Australia/Adelaide"

# Path updates
homebrew_mac_apple_silicon="/opt/homebrew/bin:/opt/homebrew/sbin"
homebrew_mac_intel="/usr/local/bin:/usr/local/sbin"
homebrew_linux="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"
dotnet_path="$HOME/.dotnet"
dotnet_tools_path="$HOME/.dotnet/tools"
adb_path="$HOME/platform-tools"
pipx_and_poetry_path="$HOME/.local/bin"
visual_studio_code_mac="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$homebrew_mac_apple_silicon:$homebrew_mac_intel:$homebrew_linux:$dotnet_path:$dotnet_tools_path:$adb_path:$pipx_and_poetry_path:$visual_studio_code_mac:$PATH"

# If brew is a command we can use
if type brew &>/dev/null; then
	homebrew_prefix="$(brew --prefix)"
	gmake="$homebrew_prefix/opt/make/libexec/gnubin"      # I want GNU's make, not the macOS default
	gnu_sed="$homebrew_prefix/opt/gnu-sed/libexec/gnubin" # I want GNU's sed, not the macOS default
	export PATH="$gnu_sed:$gmake:$PATH"
	export SHELL="$homebrew_prefix/bin/zsh"
fi

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
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'

# Better `less` options
# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
export PAGER='less'
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

## Golang paths
#export PATH="$GOROOT/bin:$PATH"
#export PATH="$GOPATH/bin:$PATH"

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

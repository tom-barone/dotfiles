export EDITOR='nvim'
export LANG=en_AU.UTF-8
export LC_CTYPE=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
#export TZ="Europe/Rome"
export TZ="Australia/Adelaide"

# Path updates
#homebrew="$homebrew_prefix/bin"
homebrew_mac_apple_silicon="/opt/homebrew/bin:/opt/homebrew/sbin"
homebrew_mac_intel="/usr/local/bin:/usr/local/sbin"
homebrew_linux="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"
dotnet="$HOME/.dotnet"
dotnet_tools="$HOME/.dotnet/tools"
adb="$HOME/platform-tools"

export "PATH=$homebrew_mac_apple_silicon:$homebrew_mac_intel:$homebrew_linux:$dotnet:$dotnet_tools:$adb:$PATH"

# Fixes to use brew's GNU tools on macOS
if type brew &>/dev/null; then # If brew is a command we can use
	homebrew_prefix="$(brew --prefix)"
	gmake="$homebrew_prefix/opt/make/libexec/gnubin"      # I want GNU's make, not the macOS default
	gnu_sed="$homebrew_prefix/opt/gnu-sed/libexec/gnubin" # I want GNU's sed, not the macOS default
	export PATH="$gnu_sed:$gmake:$PATH"
fi

# Dotnet variables
# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script#set-environment-variables
export DOTNET_ROOT=$HOME/.dotnet

# Rust
# shellcheck source=/dev/null
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

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

## Want this alias in all shells (bash, zsh, sh)
#alias google-chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

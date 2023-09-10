export EDITOR='nvim'
export LANG=en_AU.UTF-8
export LC_CTYPE=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
#export TZ="Europe/Rome"
export TZ="Australia/Adelaide"

# Path updates
dotnet="$HOME/.dotnet"
dotnet_tools="$HOME/.dotnet/tools"
adb="$HOME/platform-tools"
export "PATH=$dotnet:$dotnet_tools:$adb:$PATH"

# If brew is a command we can use
if type brew &>/dev/null; then
	homebrew_prefix="$(brew --prefix)"
	homebrew_paths="$homebrew_prefix/bin:$homebrew_prefix/sbin"
	gmake="$homebrew_prefix/opt/make/libexec/gnubin"      # I want GNU's make, not the macOS default
	gnu_sed="$homebrew_prefix/opt/gnu-sed/libexec/gnubin" # I want GNU's sed, not the macOS default
	export PATH="$homebrew_paths:$gnu_sed:$gmake:$PATH"
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

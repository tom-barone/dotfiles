export EDITOR='nvim'
export LANG=en_AU.UTF-8
export LC_CTYPE=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
#export TZ="Europe/Rome"
export TZ="Australia/Adelaide"

# Path updates
#homebrew="$homebrew_prefix/bin"
homebrew_mac_apple_silicon="/opt/homebrew/bin"
homebrew_mac_intel="/usr/local/bin"
homebrew_linux="/home/linuxbrew/.linuxbrew/bin"
adb="$HOME/platform-tools"

export "PATH=$homebrew_mac_apple_silicon:$homebrew_mac_intel:$homebrew_linux:$adb:$PATH"

## Rust paths
#export PATH="$HOME/.cargo/bin:$PATH"

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

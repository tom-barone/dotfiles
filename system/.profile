export EDITOR='nvim'
export LANG=en_AU.UTF-8
#export TZ="Europe/Rome"
export TZ="Australia/Adelaide"
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"

homebrew_prefix="$(brew --prefix)"

# Path updates
homebrew="$homebrew_prefix/bin"
goroot_bin="$GOROOT/bin"
gopath_bin="$GOPATH/bin"
adb="$HOME/platform-tools"
gmake="$homebrew_prefix/opt/make/libexec/gnubin"      # I want GNU's make, not the macOS default
gnu_sed="$homebrew_prefix/opt/gnu-sed/libexec/gnubin" # I want GNU's sed, not the macOS default

export "PATH=$homebrew:$goroot_bin:$gopath_bin:$adb:$gmake:$gnu_sed:$PATH"

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

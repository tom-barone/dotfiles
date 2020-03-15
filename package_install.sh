function check_install() {
    # Usage: check_install <program>
    if ! [ -x $(command -v $1) ]; then
        return 0
    else
        echo "$1 already installed"
        return 1
    fi;
}

package_installer=''
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "On linux, using apt package manager..."
    package_installer="sudo apt-get install"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "On Mac, using homebrew package manager..."
    package_installer="brew install"
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
    echo 'Cygwin'
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    echo 'Mingw'
else
    echo "Couldn't recognise OS. Aborting..."
    exit 1
fi

# Install vim
if check_install vim; then
    $package_installer vim
fi;

# Install neovim
if check_install nvim; then
    $package_installer neovim
fi;

# Install fzf
if check_install fzf; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi;

# Install tmuxinator completions
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O ./tmuxinator/.zsh_functions/_tmuxinator
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash -O ./tmuxinator/tmuxinator.bash

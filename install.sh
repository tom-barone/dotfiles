#!/usr/bin/env bash

function os_is() {
    uname="$(uname -a)"

    [[ "$1" == 'mac' ]] && [[ "$uname" =~ Darwin ]] && return
    [[ "$1" == 'ubuntu' ]] && [[ "$uname" =~ Ubuntu ]] && return

    false
}

package_installer=''
if os_is mac; then
    package_installer="brew install"
fi
if os_is ubuntu; then
    package_installer="sudo apt-get install -y"
fi

function have_not_installed() {
    if ! command -v $1 &> /dev/null; then
        return
    fi

    echo "$1 already installed"
    false
}

function install() {
    if have_not_installed $1; then
        $package_installer $1
    fi;
}

#####################################
# Package installs
#####################################

# Setup dotfiles and things
install stow
./setup.sh
source ~/.profile
source ~/.bashrc

# Essentials
if os_is ubuntu; then
    install build-essential # make and more
    install curl
    install wget
fi
if os_is mac; then
    xcode-select --install
    install make
fi

install vim
install neovim

# fzf
if have_not_installed fzf; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi;

# tig
if os_is mac; then
    install tig
fi
if os_is ubuntu; then
    if have_not_installed tig; then
        install libncurses5-dev
        git clone https://github.com/jonas/tig.git ~/.tig
        cd ~/.tig
        make prefix=/usr/local && sudo make install prefix=/usr/local
        cd -
    fi
fi

# cargo
if have_not_installed cargo; then
    curl https://sh.rustup.rs -ssf | bash -s -- -y --no-modify-path
    source $HOME/.cargo/env
fi

# ripgrep
if have_not_installed rg; then
    cargo install ripgrep
fi

# rbenv
if have_not_installed rbenv; then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
fi

# Install tmuxinator & completions
#if have_not_installed tmuxinator; then
    #gem install tmuxinator
    #wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O ./tmuxinator/.zsh_functions/_tmuxinator
    #wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash -O ./tmuxinator/./bin/tmuxinator.bash
#fi;

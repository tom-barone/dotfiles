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

function check_install() {
    if ! command -v $1 &> /dev/null; then
        return
    fi

    echo "$1 already installed"
    false
}

function install() {
    if check_install $1; then
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

    # remove bashrc we want our own
fi
if os_is mac; then
    xcode-select --install
    install make
fi

install vim
install neovim

# fzf
if check_install fzf; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi;

# tig
if os_is mac; then
    install tig
fi
if os_is ubuntu; then
    if check_install tig; then
        install libncurses5-dev
        git clone https://github.com/jonas/tig.git ~/.tig
        cd ~/.tig
        make prefix=/usr/local && sudo make install prefix=/usr/local
        cd -
    fi
fi

# cargo
curl https://sh.rustup.rs -ssf | bash -s -- -y --no-modify-path
source $HOME/.cargo/env

# ripgrep
cargo install ripgrep

# rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash


# Install tmuxinator & completions
#if check_install tmuxinator; then
    #gem install tmuxinator
    #wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O ./tmuxinator/.zsh_functions/_tmuxinator
    #wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash -O ./tmuxinator/./bin/tmuxinator.bash
#fi;

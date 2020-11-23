#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./helpers.sh

package_installer=''
if os_is mac; then
    package_installer="brew install"
fi
if os_is ubuntu; then
    package_installer="sudo apt-get install -y"
fi

function os_install() {
    if have_not_installed "$1"; then
        $package_installer "$1"
    fi
}

function pip_install() {
    if have_not_installed "$1"; then
        pip3 install --user "$1"
    fi
}

function npm_global_install() {
    if have_not_installed "$1"; then
        npm install --global "$1"
    fi
}

#####################################
# Package installs
#####################################

# Setup dotfiles and path variables from .profile
os_install stow
./symlink.sh
source ~/.profile

# Essentials
if os_is ubuntu; then
    sudo apt-get update
    os_install build-essential # make and more
    os_install curl
    os_install wget
fi
if os_is mac; then
    xcode-select --install
    os_install make
fi

# Python
if os_is ubuntu; then
    os_install python3.6
    os_install python3-pip
fi
#if os_is mac; then
#fi

os_install cmake
os_install vim
os_install neovim
os_install tmux
os_install shellcheck

# Dependencies
os_install bison

# gvm
if have_not_installed gvm; then
    GVM_NO_UPDATE_PROFILE=true bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi
# Go is written in Go (starting from version 1.5) so we need to install go 1.4 to bootstrap
source "$HOME/.gvm/scripts/gvm"
gvm install go1.4 -B
gvm use go1.4 
export GOROOT_BOOTSTRAP=$GOROOT

# Go lang (currently just use v15)
gvm install go1.15
gvm use go1.15

# shfmt
if have_not_installed shfmt; then
    GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
fi

# fzf
if have_not_installed fzf; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi

# tig
if os_is mac; then
    os_install tig
fi
if os_is ubuntu; then
    if have_not_installed tig; then
        os_install libncurses5-dev
        git clone https://github.com/jonas/tig.git ~/.tig
        cd ~/.tig || exit 1 # exit if cd fails
        make prefix=/usr/local && sudo make install prefix=/usr/local
        cd - || exit 1
    fi
fi

# cargo
if have_not_installed cargo; then
    curl https://sh.rustup.rs -ssf | bash -s -- -y --no-modify-path
    source "$HOME/.cargo/env"
fi

# ripgrep
if have_not_installed rg; then
    cargo install ripgrep
fi

# rbenv
if have_not_installed rbenv; then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
fi

# ruby
if have_not_installed ruby; then
    os_install autoconf
    os_install libssl-dev
    os_install libyaml-dev
    os_install libreadline6-dev
    os_install zlib1g-dev
    os_install libncurses5-dev
    os_install libffi-dev
    os_install libgdbm5
    os_install libgdbm-dev
    os_install libdb-dev

    latest_ruby_version=$(rbenv install -l | grep -v - | tail -1)
    rbenv install "$latest_ruby_version"
    rbenv global "$latest_ruby_version"
fi

# Install tmuxinator & completions
if have_not_installed tmuxinator; then
    gem install tmuxinator
    sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash -O /etc/bash_completion.d/tmuxinator.bash
fi

# Python stuff
pip3 install virtualenvwrapper

pip_install yapf
pip_install prospector

# Gcloud
# macOS 64-bit https://cloud.google.com/sdk/docs/install#mac
if os_is mac; then

    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-319.0.0-darwin-x86_64.tar.gz
    tar -xvf google-cloud-sdk-319.0.0-darwin-x86_64.tar.gz -C ~
    ~/google-cloud-sdk/install.sh
    rm google-cloud-sdk-319.0.0-darwin-x86_64.tar.gz
    ~/google-cloud-sdk/bin/gcloud init
fi
if os_is ubuntu; then
    echo 'GCLOUD NOT SETUP FOR UBUNTU'
fi

# Node
if os_is mac; then
    os_install node
fi
if os_is ubuntu; then
    echo 'NODE NOT SETUP FOR UBUNTU'
fi

# NPM stuff
npm_global_install prettier

echo ''
echo 'Running tests...'
bash --login -i -c "./test.sh"

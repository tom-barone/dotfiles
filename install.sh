#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./helpers.sh

package_installer=''
if os_is mac; then
    package_installer="brew install"
fi
if os_is ubuntu; then
    package_installer="sudo apt-get install -y"
    sudo apt-get update
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

function gem_install() {
    if have_not_installed "$1"; then
        gem install "$1"
    fi
}

#####################################
# Package installs
#####################################

# Setup dotfiles and path variables from .profile
os_install stow
./symlink.sh || { exit 1; }
source ~/.profile

# Essentials
if os_is ubuntu; then
    os_install build-essential # make and more
    os_install curl
    os_install wget
    os_install unzip
    os_install software-properties-common
fi
if os_is mac; then
    xcode-select --install
    os_install make
    os_install mono
fi

# Python
if have_not_installed python3.9; then
    if os_is ubuntu; then
        sudo add-apt-repository ppa:deadsnakes/ppa
        os_install python3.9
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python3.9 get-pip.py
        rm get-pip.py
        os_install python3-pip
    fi
    if os_is mac; then
        $package_installer python@3.9
    fi
fi

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

    ruby_version=$(rbenv version | awk '{print $1;}')
    rbenv install --skip-existing "$ruby_version"
fi

# Install tmuxinator & completions
if have_not_installed tmuxinator; then
    gem install tmuxinator
    sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash -O /etc/bash_completion.d/tmuxinator.bash
fi

gem_install rubocop
gem_install neovim
gem_install htmlbeautifier

# Python stuff
pip3 install virtualenvwrapper

pip_install yapf
pip_install prospector
pip_install poetry

# Gcloud
gcloud_sdk_url=''
if os_is mac; then
    # macOS 64-bit https://cloud.google.com/sdk/docs/install#mac
    gcloud_sdk_url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-319.0.0-linux-x86_64.tar.gz"
fi
if os_is ubuntu; then
    # Linux 64-bit https://cloud.google.com/sdk/docs/quickstart#linux
    gcloud_sdk_url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-319.0.0-darwin-x86_64.tar.gz"
fi
if have_not_installed gcloud; then
    # Download the install tar.gz
    wget $gcloud_sdk_url -O cloud-sdk.tar.gz
    # Extract it to the home dir
    tar -xvf cloud-sdk.tar.gz -C ~
    # Run the install script
    ~/google-cloud-sdk/install.sh  --usage-reporting=false --command-completion=false --path-update=false
    # Remove the install tar.gz
    rm cloud-sdk.tar.gz
fi


# NVM
# Need to do this install check because the other doesn't work for some reason
if ! [ -s "$NVM_DIR/nvm.sh" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.1/install.sh | bash
    \. "$HOME/.nvm/nvm.sh"

    # Node
    nvm install --lts
    nvm install-latest-npm
    nvm use --lts
    nvm alias default lts/*
fi

# NPM stuff
npm_global_install prettier
npm_global_install neovim

# Android platform tools
# https://developer.android.com/studio/releases/platform-tools
android_sdk=""
if os_is mac; then
    android_sdk="https://dl.google.com/android/repository/platform-tools-latest-darwin.zip"
fi
if os_is ubuntu; then
    android_sdk="https://dl.google.com/android/repository/platform-tools-latest-linux.zip"
fi
if have_not_installed adb; then
    wget $android_sdk -O android-sdk.zip
    unzip android-sdk.zip -d ~
    rm android-sdk.zip
fi

# Java 
if os_is ubuntu; then
    if have_not_installed java; then
        os_install default-jre
    fi
fi

# Google Cloud SQL proxy
proxy_file_url=""
if os_is mac; then
    proxy_file_url="https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64"
fi
if os_is ubuntu; then
    proxy_file_url="https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64"
fi
if have_not_installed cloud_sql_proxy; then
    mkdir -p ~/bin
    curl -o ~/bin/cloud_sql_proxy $proxy_file_url
    chmod +x ~/bin/cloud_sql_proxy

    sudo mkdir -p /cloudsql; sudo chmod 777 /cloudsql
fi

# Balena CLI
# https://github.com/balena-io/balena-cli/releases/latest
if os_is ubuntu; then
    if have_not_installed balena; then
        wget https://github.com/balena-io/balena-cli/releases/download/v12.40.0/balena-cli-v12.40.0-linux-x64-standalone.zip -O balena-cli.zip
        unzip balena-cli.zip -d ~
        mv ~/balena-cli ~/.balena-cli
        rm balena-cli.zip
    fi
fi

echo ''
echo 'Running post install...'
bash --login -c "./post_install.sh"

echo ''
echo 'Running tests...'
bash --login -i -c "./test.sh"

#!/usr/bin/env bash

# shellcheck source=/dev/null
source ./helpers.sh

# TODO see if we can remove duplicated code between here and bashrc
export WORKON_HOME=~/.virtualenvs
if os_is mac; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.9
    source /usr/local/bin/virtualenvwrapper.sh
fi
if os_is ubuntu; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.9
    source ~/.local/bin/virtualenvwrapper.sh
fi

# Setup python3 in nvim
mkvirtualenv nvim
pip3 install neovim
pip3 install pynvim
deactivate

# Do open of nvim and install of Youcompleteme

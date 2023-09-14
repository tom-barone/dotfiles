# dotfiles

Dotfiles per me!

Run `install.sh` to install, symlink and test everything.

## Terminal

I like [Alacritty](https://github.com/alacritty/alacritty).

## Fonts

Fonts are in the `/fonts` directory, install them however the system wants.

## Git manual installs

All installs that involve cloning a git repo, like `zsh-abbr` or `fzf` should
put them in `$HOME/opt`.

## Change the default shell

```
chsh -s "$(brew --prefix)/bin/zsh"
```

## Setup python3 for neovim

See `:help provider-python` in nvim for more details

```
mkvirtualenv nvim
pip3 install pynvim
deactivate
```

## Vscode

https://code.visualstudio.com/docs/setup/setup-overview

# TODO

1. add documentation to ./test_functions using vim-doge
1. do git status and make sure nothing has changed
1. Change the ~/code directory to ~/comunet on work laptop and
- make sure running `cd ~/comunet && git config user.email` returns
  tbarone@comunet.com.au
- make sure running `cd ~/dotfiles && git config user.email` returns
  mail@tombarone.net

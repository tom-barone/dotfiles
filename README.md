# dotfiles

Dotfiles per me!

Run `install.sh` to install, symlink and test everything.

## Terminal

I like [Alacritty](https://github.com/alacritty/alacritty).

## Fonts

Fonts are in the `/fonts` directory, install them however the system wants.

## Git manual installs

All installs that involve cloning a git repo, like `zsh-abbr` or `fzf` should put them in `$HOME/opt`.

## Change the default shell by

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

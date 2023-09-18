# dotfiles

Dotfiles per me!

Run `install.sh` to install, symlink and test everything installed correctly.

## Terminal

I like [Alacritty](https://github.com/alacritty/alacritty). I also like the git
diffs in [Vscode](https://code.visualstudio.com/docs/setup/setup-overview).

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

## Useful desktop programs

- [Google Drive for Desktop](https://www.google.com/intl/en_au/drive/download/)

# TODO

1. Change the ~/code directory to ~/comunet on work laptop and

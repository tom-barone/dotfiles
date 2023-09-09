# dotfiles

Dotfiles per me!

Start by cloning this repo.

Install [Git Credential Manager](https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md) with `brew install --cask git-credential-manager`

## To install everything from scratch

1. Run `prepare.sh` to install homebrew and stow
2. Run `install.sh` to symlink everything and kick off installation

## Fonts

Fonts are stored in the `/fonts` directory. Install them however your system wants.

## Git manual installs

All installs that involve cloning a git repo, like `zsh-abbr` or `fzf` should put them in `$HOME/opt`.

## Show system info

`neofetch`

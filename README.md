# dotfiles

Dotfiles per me!

Run `install.sh` to install, symlink and test everything.

## Fonts

Fonts are stored in the `/fonts` directory. Install them however your system wants.

## Git manual installs

All installs that involve cloning a git repo, like `zsh-abbr` or `fzf` should put them in `$HOME/opt`.

## Show system info

`neofetch`

## Change the default shell by

```
chsh -s "$(brew --prefix)/bin/zsh"
```

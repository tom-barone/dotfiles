# dotfiles

My dotfiles across macOS and WSL2/Ubuntu.

Clone and run `install.sh`. This will

1. Install everything.
2. Symlink the all config files.
3. Test everything installed correctly.

## Terminal

[Alacritty](https://github.com/alacritty/alacritty) +
[tmux](https://github.com/tmux/tmux/wiki) + [zsh](https://www.zsh.org/).

I also like the git diffs + Github Copilot chat in
[Vscode](https://code.visualstudio.com/docs/setup/setup-overview).

## Fonts

Fonts are in the `/fonts` directory, install them however the system wants. I'm
a fan of [SourceCodePro](https://fonts.google.com/specimen/Source+Code+Pro)
juiced up with [Nerd Fonts](https://www.nerdfonts.com/#home).

## Install Notes

### Installing software from source

All installs that involve cloning a git repo and installing from source, e.g.
[`zsh-abbr`](https://github.com/olets/zsh-abbr) or
[`fzf`](https://github.com/junegunn/fzf), clone the repos to `$HOME/opt` and
install from there.

### Change the default shell

Assuming you've installed `zsh` with [homebrew](https://brew.sh/):

```bash
chsh -s "$(brew --prefix)/bin/zsh"
```

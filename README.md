# dotfiles

My dotfiles across macOS and WSL2/Ubuntu.

Clone and run `install.sh`. This will

1. Install everything.
2. Symlink the all config files.
3. Test everything installed correctly.

## Terminal

[Alacritty](https://github.com/alacritty/alacritty) +
[tmux](https://github.com/tmux/tmux/wiki) + [zsh](https://www.zsh.org/) +
[nvim](https://neovim.io/) because I'm a goddamn tech hipster.

The git diffs + Github Copilot chat in
[Vscode](https://code.visualstudio.com/docs/setup/setup-overview) are good.

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

### Tmux mouse support and Windows 10

For whatever reason, there's an
[issue](https://github.com/alacritty/alacritty/issues/1663) with alacritty on
Windows 10 that causes tmux mouse mode to not work.

This
[comment](https://github.com/alacritty/alacritty/issues/1663#issuecomment-1917418514)
has a workaround for now.

### Vim commands to remember

`:GBrowse` - Open the current file in the web browser (Github etc.) with
optional line range if in visual mode

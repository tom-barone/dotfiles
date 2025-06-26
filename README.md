# dotfiles

My dotfiles across macOS and WSL2/Ubuntu.

Clone and run `install.sh`. This will

1. Install everything.
2. Symlink the all config files.
3. Test that everything installed correctly.

## Terminal

[Alacritty](https://github.com/alacritty/alacritty) +
[tmux](https://github.com/tmux/tmux/wiki) + [zsh](https://www.zsh.org/) +
[nvim](https://neovim.io/).

The git diffs + Github Copilot chat in
[Vscode](https://code.visualstudio.com/docs/setup/setup-overview) are good.

## Fonts

Fonts are in the `/fonts` directory, install them however the system wants,

I like [Source Code Pro](https://github.com/adobe-fonts/source-code-pro), the
font here has been
[patched](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-patcher)
(now under the name Sauce Code Pro) to include a bunch of extra glyphs:

- [Nerd Font](https://www.nerdfonts.com/#home)
- [powerline](https://github.com/powerline/fonts)

## Install Notes

### Installing software from source

All installs that involve cloning a git repo and installing from source, e.g.
[`zsh-abbr`](https://github.com/olets/zsh-abbr) or
[`fzf`](https://github.com/junegunn/fzf), clone the repos to `$HOME/opt` and
install from there.

### Change the default shell

Assuming `zsh` is installed with [homebrew](https://brew.sh/):

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

### GPG and signed git commits

See the [git](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work) and
[GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
docs.

```bash
# Generate a new GPG key
gpg --gen-key
# List the keys
gpg --list-keys
# Set the key to use for signing
git config --global user.signingkey <key-id>
# Make sure to always sign commits
git config --global commit.gpgsign true
# Export the public key
gpg --armor --export <key-id>
# Stop the agent (it'll auto restart when needed)
gpgconf --kill gpg-agent
# If you run into 'waiting for lock' issues
rm ~/.gnupg/public-keys.d/pubring.db.lock
```

The cache time within `gpg-agent` can be increased to avoid entering the
passphrase too often.

### MacOS

Make sure to add folders like `~/github` as exclusions in Spotlight search.
Otherwise macOS will try index folders like `.git` / `node_modules` etc. and
slow everything down.

### Vim commands to remember

`:GBrowse` - Open the current file in the web browser (Github etc.) with
optional line range if in visual mode.

`<leader>gh` - Show git history for file.

Select range -> `:Gclog` To load previous commits that affected that range.

`:BufDelete hidden` - Close all buffers not open in a window

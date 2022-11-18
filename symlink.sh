#!/usr/bin/env bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

# folders that should, or only need to be installed for a local user
dotfiles_to_symlink=(
    bash
    fish
    git
    node
    nvim
    ruby
    system
    tig
    tmux
    tmuxinator
    vim
    zsh
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t "${usr}" "${app}"
}

echo ""
echo "Symlinking dotfiles..."

for dotfiles in "${dotfiles_to_symlink[@]}"; do
    stowit "$HOME" "$dotfiles" || { echo 'Symlinking failed' ; exit 1; } 
done

# If ressys is true
if [ "$RESSYS" = true ]; then
    # symlink the files
    stowit "$HOME" ressys || { echo 'Symlinking failed' ; exit 1; }
else
    # remove the symlinks
    stow -v -R -D -t "$HOME" ressys 
fi

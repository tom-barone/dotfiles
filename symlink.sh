#!/usr/bin/env bash

dotfiles_to_symlink=(
    bash
    git
    node
    nvim
    ruby
    system
    tig
    tmux
    tmuxinator
    zsh
)

# Run the stow command for the passed in directory ($2) in location $1
stowit() {
    user=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t "${user}" "${app}"
}

echo ""
echo "Symlinking dotfiles..."

for dotfiles in "${dotfiles_to_symlink[@]}"; do
    stowit "$HOME" "$dotfiles" || { echo 'Symlinking failed' ; exit 1; } 
done

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

make_link() {
	directory=$1
	stow -v -R -t "$HOME" "${directory}"
}

echo "Symlinking dotfiles..."

for directory in "${dotfiles_to_symlink[@]}"; do
	make_link "$directory" || {
		echo 'Symlinking failed'
		exit 1
	}
done

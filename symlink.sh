#!/usr/bin/env bash

dotfiles_to_symlink=(
	alacritty
	bash
	fzf
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
	stow --verbose --restow --target "$HOME" "${directory}"
}

adopt_link() {
	directory=$1
	stow --verbose --adopt --target "$HOME" "${directory}"
}

delete_link() {
	directory=$1
	stow --verbose --delete --target "$HOME" "${directory}"
}

for directory in "${dotfiles_to_symlink[@]}"; do
	if [[ $1 == "--delete" ]]; then
		delete_link "$directory" || {
			echo 'Removing symlinks failed'
			exit 1
		}
	elif [[ $1 == "--adopt" ]]; then
		adopt_link "$directory" || {
			echo 'Adopting symlinks failed'
			exit 1
		}
	else
		make_link "$directory" || {
			echo 'Symlinking failed'
			exit 1
		}
	fi
done

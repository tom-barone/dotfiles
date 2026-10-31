#!/usr/bin/env bash

dotfiles_to_symlink=(
	aerc
	agents
	alacritty
	bash
	claude
	codex
	fzf
	gemini
	git
	gpg
	nvim
	mise
	ripgrep
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

# Claude Code only reads ~/.claude/skills. Link each skill on its own so
# claude.ai's synced/ skills stay out of the shared directory. This runs
# before stow so ~/.claude is still there when deleting.
for skill in agents/.agents/skills/*/; do
	skill=$(basename "$skill")
	if [[ $1 == "--delete" ]]; then
		rm -f "$HOME/.claude/skills/$skill"
	else
		mkdir -p "$HOME/.claude/skills"
		ln -sfn "$HOME/.agents/skills/$skill" "$HOME/.claude/skills/$skill"
	fi
done

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

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
[[ ! -f ~/.p10k_instant_prompt.zsh ]] || source ~/.p10k_instant_prompt.zsh

# P10k
[[ ! -f ~/opt/powerlevel10k/powerlevel10k.zsh-theme ]] || source ~/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
set-terminal-title() {
	echo -en "\033]0;$1\a"
}

# History sizes
export SAVEHIST=1000000
export HISTSIZE=1000000
export HIST_IGNORE_SPACE=true
export HISTFILE=~/.zsh_history

# Use emacs mode
bindkey -e

# Make the delete key work
bindkey "^[[3~" delete-char

# Load nice zsh arg completions (already done from stuff below)
autoload -U +X compinit && compinit

# Search history using whats on the line already (because .inputrc isn't loaded for zsh)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Gcloud config
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Rbenv init (if rbenv is installed)
if type rbenv &>/dev/null; then
	eval "$(rbenv init - zsh)"
fi

# Plugins
[[ ! -f ~/opt/zsh-abbr/zsh-abbr.zsh ]] || source ~/opt/zsh-abbr/zsh-abbr.zsh # this needs to be initialised down the bottom because of https://zsh-abbr.olets.dev/advanced.html#vi-mode

# FZF load
[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh
[[ -f "$HOME/.config/zsh/fzf_git.zsh" ]] && source "$HOME/.config/zsh/fzf_git.zsh"

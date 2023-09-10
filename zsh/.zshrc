# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Use emacs mode
bindkey -e

## Load nice zsh arg completions (already done from stuff below)
#if ! (( $+functions[compdef] )) ; then
    #autoload -U +X compinit && compinit
#fi

# Search history using whats on the line already (because .inputrc isn't loaded for zsh)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Gcloud config
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

### FZF Config
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!.git/*"'
source ~/.config/zsh/fzf_git.zsh

# Rbenv init (if rbenv is installed)
if type rbenv &> /dev/null; then
	eval "$(rbenv init - zsh)"
fi

### Virtualenvwrapper
#export WORKON_HOME=~/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh

# Plugins
[[ ! -f ~/opt/zsh-abbr/zsh-abbr.zsh ]] || source ~/opt/zsh-abbr/zsh-abbr.zsh # this needs to be initialised down the bottom because of https://zsh-abbr.olets.dev/advanced.html#vi-mode
[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

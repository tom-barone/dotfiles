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

# Plugins
[[ ! -f ~/opt/zsh-abbr/zsh-abbr.zsh ]] || source ~/opt/zsh-abbr/zsh-abbr.zsh
[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
set-terminal-title() {
    echo -en "\033]0;$1\a"
}

# History sizes
export SAVEHIST=1000000
export HISTSIZE=1000000
export HIST_IGNORE_SPACE=true

# Search history using whats on the line already (because .inputrc isn't loaded for zsh)
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Set option-forward and option-backward to go forward/backward a word
bindkey "^[B" backward-word
bindkey "^[F" forward-word

# Gcloud config
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

### NVM config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # --no-use  # This loads nvm

### FZF Config
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!.git/*"'
source ~/.config/zsh/fzf_git.zsh

# Rbenv init
eval "$(rbenv init -)"

### Virtualenvwrapper
#export WORKON_HOME=~/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh

# Rust
source "$HOME/.cargo/env"

# Fixes to use brew's GNU tools on macOS
homebrew_prefix="$(brew --prefix)"
gmake="$homebrew_prefix/opt/make/libexec/gnubin"      # I want GNU's make, not the macOS default
gnu_sed="$homebrew_prefix/opt/gnu-sed/libexec/gnubin" # I want GNU's sed, not the macOS default
export PATH="$gnu_sed:$gmake:$PATH"

## zsh-autosuggestions
bindkey '^s' autosuggest-accept


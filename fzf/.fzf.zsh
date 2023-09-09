# Setup fzf
# ---------
if [[ ! "$PATH" == */$HOME/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/$HOME/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/$HOME/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/$HOME/opt/fzf/shell/key-bindings.zsh"

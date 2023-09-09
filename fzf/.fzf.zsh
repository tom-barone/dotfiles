# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/tbone/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/tbone/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/tbone/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/tbone/opt/fzf/shell/key-bindings.zsh"

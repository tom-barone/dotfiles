# zsh only runs ~/.zprofile, not ~/.profile - so load it here
emulate sh
. ~/.profile
emulate zsh

# FPATH updates (for zsh completions)
# Get all the ZSH functions installed by homebrew
homebrew_prefix="$(brew --prefix)"
export FPATH="$HOME/.zsh_functions:$homebrew_prefix/share/zsh/functions:$homebrew_prefix/share/zsh/site_functions:$HOME/opt/zsh-completions/src:/usr/share/zsh/vendor-completions:$FPATH"

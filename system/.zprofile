# zsh only runs ~/.zprofile, not ~/.profile - so load it here
emulate sh
. ~/.profile
emulate zsh

eval "$(direnv hook zsh)"

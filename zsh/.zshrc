######################
#  GENERAL SETTINGS  #
######################
## ZSH
autoload -U compinit
compinit

## Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
fzf "$@" --border
}

gf() {
    is_in_git_repo || return
    git -c color.status=always status --short |
        fzf-down -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c4- | sed 's/.* -> //'
    }

gb() {
    is_in_git_repo || return
    git branch -a --color=always | grep -v '/HEAD\s' | sort |
        fzf-down --ansi --multi --tac --preview-window right:70% \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
        sed 's/^..//' | cut -d' ' -f1 |
        sed 's#^remotes/##'
    }

gt() {
    is_in_git_repo || return
    git tag --sort -version:refname |
        fzf-down --multi --preview-window right:70% \
        --preview 'git show --color=always {} | head -'$LINES
    }

gh() {
    is_in_git_repo || return
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
        grep -o "[a-f0-9]\{7,\}"
    }

gr() {
    is_in_git_repo || return
    git remote -v | awk '{print $1 "\t" $2}' | uniq |
        fzf-down --tac \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
        cut -d$'\t' -f1
    }

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper

export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'

## Tmuxinator
export EDITOR='nvim'
fpath=( ~/.zsh_functions $fpath )

## Aliases
alias mux='tmuxinator'

############
#  OLD ZSH #
############

# If you come from bash you might have to change your $PATH.
 export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="/Users/tbone/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="tbone"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git tmuxinator)

#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
DEFAULT_USER=`whoami`

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

## Ruby stuff 
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"

alias edb="nvim ~/.zshrc"
alias srb='source ~/.zshrc'



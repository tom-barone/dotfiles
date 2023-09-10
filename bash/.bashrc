# bashrc - Thomas Barone

# rbenv
eval "$(rbenv init - bash)"

# Fixes to use brew's GNU tools on macOS
homebrew_prefix="$(brew --prefix)"
#homebrew_cellar="$(brew --cellar)"
gmake="$homebrew_prefix/opt/make/libexec/gnubin"      # I want GNU's make, not the macOS default
gnu_sed="$homebrew_prefix/opt/gnu-sed/libexec/gnubin" # I want GNU's sed, not the macOS default
export PATH="$gnu_sed:$gmake:$PATH"

## shellcheck source=/dev/null
#source ~/dotfiles/helpers.sh

#######################
##  GENERAL SETTINGS  #
#######################
### Common defaults
## See https://gist.github.com/awesomebytes/c5885775ac9b7429cfcf7cb99b14f3cf

## ~/.bashrc: executed by bash(1) for non-login shells.
## see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
## for examples

## If not running interactively, don't do anything
#case $- in
    #*i*) ;;
    #*) return;;
#esac

## don't put duplicate lines or lines starting with space in the history.
## See bash(1) for more options
#HISTCONTROL=ignoreboth

## append to the history file, don't overwrite it
#shopt -s histappend

## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000000
#HISTFILESIZE=1000000

## check the window size after each command and, if necessary,
## update the values of LINES and COLUMNS.
#shopt -s checkwinsize

## If set, the pattern "**" used in a pathname expansion context will
## match all files and zero or more directories and subdirectories.
##shopt -s globstar

## make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    #debian_chroot=$(cat /etc/debian_chroot)
#fi

## set a fancy prompt (non-color, unless we know we "want" color)
##case "$TERM" in
    ##xterm-color|*-256color) color_prompt=yes;;
##esac

## uncomment for a colored prompt, if the terminal has the capability; turned
## off by default to not distract the user: the focus in a terminal window
## should be on the output of commands, not on the prompt
##force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
    #if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        ## We have color support; assume it's compliant with Ecma-48
        ## (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        ## a case would tend to support setf rather than setaf.)
        #color_prompt=yes
    #else
        #color_prompt=
    #fi
#fi

#if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

## If this is an xterm set the title to user@host:dir
##case "$TERM" in
    ##xterm*|rxvt*)
        ##PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ##;;
    ##*)
        ##;;
##esac

## enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    ##alias dir='dir --color=auto'
    ##alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
#fi


## Add an "alert" alias for long running commands.  Use like so:
##   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
    #if [ -f /usr/share/bash-completion/bash_completion ]; then
        #. /usr/share/bash-completion/bash_completion
    #elif [ -f /etc/bash_completion ]; then
        #. /etc/bash_completion
    #fi
#fi

## make tab cycle through commands after listing
#bind "TAB:menu-complete"
#bind '"\e[Z":menu-complete-backward'
#bind "set show-all-if-ambiguous on"
#bind "set completion-ignore-case on"
#bind "set colored-stats on"
#bind "set colored-completion-prefix on"

### Git functions
#parse_git_dirty () {
    #[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
#}
#parse_git_branch () {
    #git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
#}

### Prompt format

#if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    ## If ssh'ed into somewhere - use a prompt with no colour
    #PS1="\[${BOLD}\]\u \W\[$BASE0\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")\$(parse_git_branch)\[$BASE0\]\n\$ \[$RESET\]"
#else
    ## Use a nice pretty prompt
    #PS1="\[${BOLD}${CYAN}\]\u \[$BLUE\]\W\[$BASE0\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")\[$YELLOW\]\$(parse_git_branch)\[$BASE0\]\n\$ \[$RESET\]"
#fi

### Fzf
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#bind -m emacs-standard -x '"\C-p": fzf-file-widget'
#bind -m emacs-standard -x '"\C-t": fzf'

#is_in_git_repo() {
    #git rev-parse HEAD > /dev/null 2>&1
#}

#fzf-down() {
#fzf "$@" --border
#}

#gf() {
    #is_in_git_repo || return
    #git -c color.status=always status --short |
        #fzf-down -m --ansi --nth 2..,.. \
        #--preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        #cut -c4- | sed 's/.* -> //'
    #}

#gb() {
    #is_in_git_repo || return
    #git branch -a --color=always | grep -v '/HEAD\s' | sort |
        #fzf-down --ansi --multi --tac --preview-window right:70% \
        #--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
        #sed 's/^..//' | cut -d' ' -f1 |
        #sed 's#^remotes/##'
    #}

#gt() {
    #is_in_git_repo || return
    #git tag --sort -version:refname |
        #fzf-down --multi --preview-window right:70% \
        #--preview 'git show --color=always {} | head -'$LINES
    #}

#gh() {
    #is_in_git_repo || return
    #git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        #fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        #--header 'Press CTRL-S to toggle sort' \
        #--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
        #grep -o "[a-f0-9]\{7,\}"
    #}

#gr() {
    #is_in_git_repo || return
    #git remote -v | awk '{print $1 "\t" $2}' | uniq |
        #fzf-down --tac \
        #--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
        #cut -d$'\t' -f1
    #}

#bind '"\er": redraw-current-line'
#bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
#bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
#bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
#bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
#bind '"\C-g\C-r": "$(gr)\e\C-e\er"'

#export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden --glob "!**/.git/*" --glob "!node_modules/*"'
#export FZF_DEFAULT_OPTS='--bind ctrl-a:toggle-all'

### Tmuxinator
#export EDITOR='nvim'
#source ~/.bin/tmuxinator.bash

### Virtualenvwrapper
#export WORKON_HOME='~/.virtualenvs'

#if os_is mac; then
    #export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    #source /usr/local/bin/virtualenvwrapper.sh
#fi
#if os_is ubuntu; then
    #export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    #source ~/.local/bin/virtualenvwrapper.sh
#fi

### rbenv
#eval "$(rbenv init -)"

### Go
## shellcheck source=/dev/null
#[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
#gvm use go1.15 >/dev/null 2>&1

### Gcloud
## The next line updates PATH for the Google Cloud SDK.
#if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi
## The next line enables shell command completion for gcloud.
#if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/google-cloud-sdk/completion.bash.inc"; fi

## Android Platform Tools
#if [ -d "$HOME/platform-tools" ] ; then
 #export PATH="$HOME/platform-tools:$PATH"
#fi

### NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

################
##  SHORTCUTS  #
################
### Aliases
#alias edb='nvim ~/.bashrc'
#alias srb='source ~/.bashrc'
#alias edit-tmux-conf='nvim ~/.tmux.conf'
#alias source-tmux-conf='tmux source-file ~/.tmux.conf'
#alias edit-gitignore_global='nvim ~/.gitignore_global'
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'
#alias c.='code . &'
#alias ad='alert "Done"'
#alias gp='git pull --rebase'
#alias copy='xclip -selection clipboard'
#alias pgadmin4='/usr/pgadmin4/bin/pgadmin4 &>/dev/null &'
#alias ssh-minecraft-server='gcloud beta compute ssh --zone "australia-southeast2-b" "minecraft-1"  --project "packed-to-the-crafters"'
#alias ssh-beancount-server='gcloud beta compute ssh --zone "australia-southeast2-b" "beancount"  --project "beancount-322303"'
#alias ssh-cicero='ssh tbone@192.168.0.9'


### Functions
#### Change terminal title
#function set-terminal-title() {
    ## usage: set-terminal-title <new_title>
    #echo -en "\033]0;$1\a"
#}

#### Show branch history
#function branch-history() {
    #for branch in `git branch -r --merged | grep -v HEAD`; 
        #do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; 
    #done | sort -r
#}
#alias cfg='/usr/bin/git --git-dir=/home/tomb/.cfg/ --work-tree=/home/tomb'

#### Merge pdfs
#function pdfmerge() {
    #gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="$1" "${@:2}"
#}
#alias cfg='/usr/bin/git --git-dir=/home/tomb/.cfg/ --work-tree=/home/tomb'

#nvm use default --silent

#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

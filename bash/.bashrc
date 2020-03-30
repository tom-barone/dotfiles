# bashrc - Thomas Barone

######################
#  GENERAL SETTINGS  #
######################
## Common defaults
# See https://gist.github.com/awesomebytes/c5885775ac9b7429cfcf7cb99b14f3cf

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

## Solarized theme

# Sexy Solarized Bash Prompt, inspired by "Extravagant Zsh Prompt"
# Screenshot: http://img.gf3.ca/d54942f474256ec26a49893681c49b5a.png
if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then TERM=gnome-256color; fi
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
        BASE03=$(tput setaf 234)
        BASE02=$(tput setaf 235)
        BASE01=$(tput setaf 240)
        BASE00=$(tput setaf 241)
        BASE0=$(tput setaf 244)
        BASE1=$(tput setaf 245)
        BASE2=$(tput setaf 254)
        BASE3=$(tput setaf 230)
        YELLOW=$(tput setaf 136)
        ORANGE=$(tput setaf 166)
        RED=$(tput setaf 160)
        MAGENTA=$(tput setaf 125)
        VIOLET=$(tput setaf 61)
        BLUE=$(tput setaf 33)
        CYAN=$(tput setaf 37)
        GREEN=$(tput setaf 64)
    else
        BASE03=$(tput setaf 8)
        BASE02=$(tput setaf 0)
        BASE01=$(tput setaf 10)
        BASE00=$(tput setaf 11)
        BASE0=$(tput setaf 12)
        BASE1=$(tput setaf 14)
        BASE2=$(tput setaf 7)
        BASE3=$(tput setaf 15)
        YELLOW=$(tput setaf 3)
        ORANGE=$(tput setaf 9)
        RED=$(tput setaf 1)
        MAGENTA=$(tput setaf 5)
        VIOLET=$(tput setaf 13)
        BLUE=$(tput setaf 4)
        CYAN=$(tput setaf 6)
        GREEN=$(tput setaf 2)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    # Linux console colors. I don't have the energy
    # to figure out the Solarized values
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

## Git functions
parse_git_dirty () {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
parse_git_branch () {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

## Prompt format

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # If ssh'ed into somewhere - use a prompt with no colour
    PS1="\[${BOLD}\]\u \W\[$BASE0\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")\$(parse_git_branch)\[$BASE0\]\n\$ \[$RESET\]"
else
    # Use a nice pretty prompt
    PS1="\[${BOLD}${CYAN}\]\u \[$BLUE\]\W\[$BASE0\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \")\[$YELLOW\]\$(parse_git_branch)\[$BASE0\]\n\$ \[$RESET\]"
fi

## Fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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

bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'

export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*" --glob "!node_modules/*"'
export FZF_DEFAULT_OPTS='--bind ctrl-a:toggle-all'

## Tmuxinator
export EDITOR='nvim'
source ~/.bin/tmuxinator.bash

## Virtualenvwrapper
source /home/tomb/.local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=python3

## rbenv
eval "$(rbenv init -)"

############
#  RESSYS  #
############
source /ressys/deployment-commons/assets/etc_profile.d/rs-switch-aws-cli-profile.sh
source /ressys/deployment-commons/assets/etc_profile.d/rs-go-typical-functions.sh
source /ressys/deployment-commons/assets/etc_profile.d/mm-credential-functions.sh

# GoLang
#export GOROOT=$HOME/.go
export PATH=$PATH:$GOROOT/bin

[[ -s "/home/tomb/.gvm/scripts/gvm" ]] && source "/home/tomb/.gvm/scripts/gvm"

export NVM_DIR="/home/tomb/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export IN_DOCKER_SSH_FOLDER_FOR_BITBUCKET_CLONING=~/.ssh/bitbucket-ro-clone-folder/

###############
#  SHORTCUTS  #
###############
## Aliases
alias edb='nvim ~/.bashrc'
alias srb='source ~/.bashrc'
alias edit-tmux-conf='nvim ~/.tmux.conf'
alias source-tmux-conf='tmux source-file ~/.tmux.conf'
alias edit-gitignore_global='nvim ~/.gitignore_global'
alias rs='cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems'
alias rsr='rs-go-reporting_www'
alias rsf='rs-go-falcon'
alias rsu='rs-go-uploader'
alias rst='rs-go-maxmine-www-tests'
alias rss='cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/ressys-python-selenium'
alias rst='rs-go-maxmine-www-tests'
alias rsd='cd /ressys/deployment-commons'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c.='code . &'
alias go-generate='cd App/; GOPATH=/ressys/reporting-www-gopath/; go generate; cd ..'
alias ad='alert "Done"'
alias gp='git pull --rebase'
alias ssh-autoreports='ssh autoreports-server.max-mine.com'
alias copy='xclip -selection clipboard'

## Functions
### Goto repo
# TODO: add these to rs-go-typical if they are that useful
function rs-go-falcon() {
    echo "Going to falcon repo and setting proper env."
    echo cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/falcon/
    cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/falcon/
}

function rs-go-maxmine-www-tests() {
    echo "Going to maxmine-www-tests repo and setting proper env."
    echo cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/maxmine-www-tests/
    cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/maxmine-www-tests/
}


### Get minesite configuration
function get-minesite-config() {
    # Usage: get-minesite-config <minesite_id>
    curl --silent -u `MMResCreds` https://python-dashboard.max-mine.com/central-resources-api/minesiteconfigurations | jq -r '.minesiteconfigurations[] | select(.MinesiteId=="'$1'")'
}

### Get minesite live dp version
function get-minesite-live-dp-version() {
    # Usage: get-minesite-config <minesite_id>
    #curl --silent -u `MMResCreds` https://python-dashboard.max-mine.com/general-info/minesites-live-info | jq -r '.minesiteconfigurations[] | select(.MinesiteId=="'$1'")'
    #curl --silent -u `MMResCreds` https://python-dashboard.max-mine.com/general-info/minesites-live-info | jq .
    curl --silent 'https://python-dashboard.max-mine.com/general-info/minesites-live-info' -H 'cookie: user-details="2|1:0|10:1563932462|12:user-details|44:InRvbS5iYXJvbmVAcmVzb2x1dGlvbi5zeXN0ZW1zIg==|9de32feb8a620c353986d043f4092d8f97e5fcb4a6bc45fe044ed3770e05a1e0"' | jq -r '."'$1'".currentDPChannelInfo.channelName'
}

### Get minesite results bucket
function get-minesite-bucket() {
    # usage: get-minesite-bucket <minesite_id>
    get-minesite-config $1 | jq -r '.ResultsBucketAWSARN' | grep -o "mm.*$" 
}

### Upload latest minesite data
function upload-latest-minesite-data() {
    # usage: upload-latest-minesite-data <minesite_id> <host>

    rsu
    local username=apiuploader@resolution.systems
    local password=NDxWryPA
    #local dpVersion=jenkins-ci-end-to-end-294
    #local dpVersion=jenkins-ci-end-to-end-319
    #local dpVersion=20200204-v8.8-f5.32
    local dpVersion=20200317-v8.9-f5.33

    local bucket=$(get-minesite-bucket $1)
    #local uploader=ressys-www-uploader-2.8.2-f5.32.0.linux
    #local uploader=ressys-www-uploader-9.9.9+DevProductivity-429ffcbe.linux
    #local uploader=ressys-www-uploader-2.8.3-f5.33.0.linux
    local uploader=ressys-www-uploader-2.8.3-f5.33.0.linux

    echo "AWS_REGION=ap-southeast-2 ./$uploader -username $username -password $password -dpVersion $dpVersion -api $2 -bucket $bucket -threads=100 "${@:3}""
    AWS_REGION=ap-southeast-2 ./$uploader -username $username -password $password -dpVersion $dpVersion -api $2 -bucket $bucket -threads=100 "${@:3}"

    cd -
}

### Show available uploader versions
function show-uploader-versions() {
    aws s3 ls s3://deployment-max-mine-com/binaries/www-uploader/
}

### Get uploader
function get-uploader() {
    # Usage: get-uploader ressys-www-uploader-2.7.2-f5.30.0.linux

    # Go to uploader folder
    rsu

    # Download and set proper permissions
    aws s3 cp s3://deployment-max-mine-com/binaries/www-uploader/$1 .
    chmod +x $1

    # Go back
    cd -
}

### Change terminal title
function set-terminal-title() {
    # usage: set-terminal-title <new_title>
    echo -en "\033]0;$1\a"
}

### Convert HRC report
function hrc-convert() {
    cd ~/Downloads
    convert -density 150 ~/Downloads/$1-2020_HaulRoadConditionReport.pdf -quality 90 -flatten ~/Downloads/$1-2020_HaulRoadConditionReport.png
    cd -
}

### Show branch history
function branch-history() {
    for branch in `git branch -r --merged | grep -v HEAD`; 
        do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; 
    done | sort -r
}

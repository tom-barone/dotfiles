if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U FZF_CTRL_T_OPTS "--preview $(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200"
end

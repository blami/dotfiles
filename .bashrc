# ~/.bashrc: bash resource file
# NOTE: this file is sourced by non-login shells only.

# Source environment settings
[ -f $HOME/.sh_profile ] && . $HOME/.sh_profile

# Everything else is only for interactive shells
[ -z "$PS1" ] && return

# Clear DEBUG trap
trap - DEBUG

# {{{ General
# Directory navigation
shopt -s autocd                         # autocd when 'cd' is omitted
shopt -s cdspell
shopt -u direxpand                      # don't expand directory names

# Globbing
shopt -s dotglob                        # include .files in glob results
shopt -s extglob                        # extended globs ?*+@!(...)
shopt -s globstar                       # ** matches all files **/ dirs only

# Misc
shopt -u mailwarn                       # don't warn about ~/mail
set -o vi                               # use emacs style editing
# }}}


# {{{ History
shopt -s cmdhist                        # store n-line stmts as 1-line
shopt -s lithist                        # in n-line stmts use \n instead of ;
shopt -s histappend                     # append history instead of overwrite
shopt -s histreedit
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=4096
HISTIGNORE='&:logout:exit:clear:reset:history'
HISTFILESIZE=$HISTSIZE
HISTFILE=$HOME/.bash_history.$HOST

# Share history between multiple sessions on same machine
# See: _promptcmd() below
# }}}


# {{{ Prompt
shopt -s promptvars                     # expand variables in prompt
shopt -s checkjobs                      # check background jobs on exit
shopt -s checkwinsize                   # update LINES/COLUMNS
shopt -s interactive_comments           # allow comments in interactive shell

PS1='$ '
PS1_L=                                  # left side of prompt
PS1_R=                                  # right side of prompt

PS2='    '
PS3='#?> '

# Prompt command
prompt_command() {
    local ret=$?
    local lastcmd=$(HISTTIMEFORMAT='%s '; history 1);
    # Share history between sessions
    builtin history -a ; builtin history -c ; builtin history -r

    # Prompt/title variables
    # ----------------------
    # Date
    local date=$(date +%R)

    # Work directory
    local pwd=${PWD/$HOME/\~}
    [ -L $HOME ] && pwd=${pwd/$(readlink -m $HOME)/\~}

    local pwd_=${pwd//[^\/]} ; pwd_=${#pwd_}
    if [ $pwd_ -gt 3 ]; then
        IFS='/' ; pwd=($pwd) ; unset IFS
        pwd="${pwd[0]}..${pwd[$(($pwd_-1))]}/${pwd[$(($pwd_))]}"
    fi

    # Sign
    local sign="\$" ; [ $EUID -eq 0 ] && sign="\#"

    # Return code
    [ $ret == 0 ] && ret= || ret="${ret} "

    # Xterm title
    # -----------
    case "$TERM" in
        xterm*|rxvt*) echo -ne "\e]0;SH: [$HOST] $pwd\a" ;;
        #screen*) echo -ne "\0]0;$HOST\a" ;;
    esac

    # Prompt
    # ------
    # HH:MM [user@host] pwd                                         (git|venv)
    # 1 $ _

    PS1_L="${date} [${USER}@${HOST}] ${pwd}"
    PS1_R=""
    [ $(($COLUMNS-${#PS1_L}-${#PS1_R}-1)) -lt 0 ] && PS1_R=

    printf "\n%b%$(($COLUMNS-${#PS1_L}))b\n" "$PS1_L" "$PS1_R"
    PS1="${ret}${sign} "
}
PROMPT_COMMAND=prompt_command           # command to run before each prompt
# }}}


# {{{ Completion
shopt -s no_empty_cmd_completion        # don't complete from empty line
# }}}


# vim:set ft=sh:

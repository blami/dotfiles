# ~/.bashrc: bash resource file
# NOTE: this file is sourced by non-login shells only.

# Source environment settings
[ -f $HOME/.sh_profile ] && . $HOME/.sh_profile

# Everything else is only for interactive shells
[ -z "$PS1" ] && return

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
HISTSIZE=1000
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
PS2='    '
PS3='#?> '

# Prompt command
prompt_command() {
    local ret=$?
    # Share history between sessions
    builtin history -a ; builtin history -c ; builtin history -r

    # Setup prompt
    # ------------
    # HH:MM user[@host] [()] pwd
    # [ret] $ _

    # Date
    local date=$(date +%R)

    # User and host
    local user=$USER
    local host=$HOST

    # Work directory
    local pwd=$PWD
    pwd=${pwd/$HOME/\~}
    [ -L $HOME ] && pwd=${pwd/$(readlink -m $HOME)/\~}
    # When longer than 4 items 
    local pwdl=${pwd//[^\/]} ; pwdl=${#pwdl}
    if [ $pwdl -gt 3 ]; then
        IFS='/' ; pwd=($pwd) ; unset IFS
        pwd="${pwd[0]}/${pwd[1]}...${pwd[$(($pwdl-1))]}/${pwd[$(($pwdl))]}"
    fi

    [ $ret == 0 ] && ret=
    local sign="\$" ; [ $EUID -eq 0 ] && sign="\#"

    # Date
    local date=$(date +%R)

    # User
    local user=$USER
    [ ! -z "$SSH_CONNECTION" ] && user="$user@$HOST"

    # Working directory (substitute home portion with ~)
    # NOTE If pwd is over five components keep first and last two

    # Xterm title
    # -----------
    case "$TERM" in
        xterm*|rxvt*) echo -ne "\e]0;SH: [$HOST] $pwd\a" ;;
    esac

    # Prompt
    # ------
    # NOTE: Use echo -e for lines, on completion only PS1 will be printed
    echo -e "\n${date} ${user} ${pwd}"
    PS1="${ret}${sign} "
}
PROMPT_COMMAND=prompt_command           # command to run before each prompt
# }}}


# {{{ Completion
shopt -s no_empty_cmd_completion        # don't complete from empty line
# }}}



# vim:set ft=sh:

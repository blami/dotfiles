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

PS2='    '
PS3='#?> '


# Prompt command
prompt_command() {
    local exit_code=$?
    # Share history between sessions (disabled for convenience)
    #builtin history -a ; builtin history -c ; builtin history -r

    # Setup prompt variables
    # ----------------------
    # Working directory
    local pwd=${PWD/$HOME/\~}
    local user=$USER

    # Xterm title
    case "$TERM" in
        xterm*|rxvt*) echo -ne "\033]0;SH: [$HOST] $pwd\a" ;;
    esac

    # Prompt
    # NOTE: Use echo -e for lines
    echo -e "\n$(date +%R) $user $pwd"
    PS1="\$ "
}
PROMPT_COMMAND=prompt_command           # command to run before each prompt
# }}}


# {{{ Completion
shopt -s no_empty_cmd_completion        # don't complete from empty line
# }}}


# {{{ Includes
# Interactive functions and aliases
[ -r $HOME/.sh_funcs ] && source $HOME/.sh_funcs
[ -r $HOME/.sh_aliases ] && source $HOME/.sh_aliases

# Login script
[ -r $HOME/.sh_login ] && source $HOME/.sh_login

# Clear exit code (if any optional file doesn't exist)
builtin true
# }}}


# vim:set ft=sh:

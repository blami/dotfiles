# ~/.zshrc - Z shell configuration

# Z shell configuration
# ---------------------
#
# Configuration file sourcing order (L-login,N-nonlogin,S-script)
#           L   N   S
# .zshenv   1   1   1
# .zprofile 2
# .zshrc    3   3
# .zlogin   4
# .zlogout  X
#
# Explanation of used options:
# http://zsh.sourceforge.net/Doc/Release/Options.html
# http://zsh.sourceforge.net/Doc/Release/Parameters.html
#
# vared
# =ls -> /bin/ls
# =(ls) -> filename(output of ls)
# <(ls) -> named pipe
# ^X* -> expand word
#

# Skip this file for non-interactive shells
[[ -z "$PS1" ]] && return


# {{{ General
# Allow use of unset variables
setopt unset

# Job control
setopt check_jobs
setopt longlistjobs
unsetopt bg_nice
unsetopt notify
unsetopt hup
# Make disown'ed jobs automatically continue
setopt auto_continue
REPORTTIME=60
REPORTMEMORY=128

# E-mail checks
unsetopt mail_warning
MAILCHECK=
# }}}


# {{{ Expansion, Globbing & Scripting
setopt globdots
setopt no_case_glob
setopt no_extended_glob

# Redirection - don't clobber with >; allow multiple redirections
unsetopt clobber
setopt multios

setopt interactive_comments
setopt c_bases
setopt short_loops
# }}}


# {{{ Changing directories
setopt auto_cd

# Directory stack
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_to_home

# Don't resolve symlinks to real paths on cd'ing
unsetopt chase_links
unsetopt chase_dots

# Hash commands and directory names
setopt hash_cmds
setopt hash_dirs
# }}}


# {{{ Editing
zmodload -i zsh/zle
setopt zle
# Set vi editing mode
bindkey -v
# Set ESC after-press delay to 0.1s
export KEYTIMEOUT=1

unsetopt correct
unsetopt beep
unsetopt list_beep
# }}}


# {{{ Prompt
# Allow substitutions and have RPROMPT only on last line
setopt promptsubst
setopt transientrprompt
autoload -Uz promptinit
promptinit
# NOTE Moved to the end of file to ensure prompt_precmd hook is last
#prompt blami
# }}}


# {{{ History
# Increment history immediately, store on command exit (accurate elapsed time)
setopt inc_append_history_time
setopt extended_history
HISTFILE=~/.zsh_history.$HOST
HISTSIZE=16384
SAVEHIST=16384
HISTIGNORE="&:ls:ll:la:mc:reset:clear:cd:cd ..:exit"
setopt hist_verify

# Ignore duplicates, spaces and history function itself
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store
# Ignore all duplicates (not only previous/next)
setopt hist_ignore_all_dups
setopt hist_expire_dups_first

# Sync history between sessions
autoload -Uz add-zsh-hook
hist_precmd () {
    # builtin fc -RI
}
add-zsh-hook precmd hist_precmd
# }}}


# {{{ Completion
#autoload -Uz compinit
#compinit -u

setopt completeinword
# }}}


# {{{ Includes
# Local configuration
[ -r ~/.zshrc_local ] && . ~/.zshrc_local || builtin true
[ -r ~/.zshrc_$HOST ] && . ~/.zshrc_$HOST || builtin true

# Additional files
[ -r ~/.zalias ] && . ~/.zalias || builtin true
[ -r ~/.zbindkey ] && . ~/.zbindkey || builtin true
# }}}


# {{{ Prompt
#TRAPWINCH() {
#    zle reset-prompt
#    zle && zle -R
#}

#TMOUT=1
#TRAPALRM() {
#    zle reset-prompt
#    zle && zle -R
#}

# NOTE Moved to the end of file to ensure prompt_precmd hook is last
prompt blami
# }}}

# vim:set ft=zsh:

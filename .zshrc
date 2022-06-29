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

autoload -Uz \
    add-zsh-hook \
    promptinit \
    #compinit

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
promptinit
# NOTE: Moved to the end of file to ensure prompt_precmd hook is last
#prompt blami
# }}}


# {{{ History
HISTFILE=~/.zsh_history.$HOSTNICK
HISTSIZE=16384
SAVEHIST=16384
HISTIGNORE="&:ls:ll:la:mc:reset:clear:cd:exit"
setopt hist_verify
# Save history immediately and share between sessions
#setopt append_history       # KEEP this off if share_history
#setopt inc_append_history   # KEEP this off if share_history
setopt share_history        # this behaves as inc_append_history(_time)
setopt extended_history
# Ignore duplicates, spaces and history function itself
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store
# Ignore all duplicates (not only previous/next)
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
# }}}


# {{{ Completion
#autoload -Uz compinit
#compinit -u

setopt completeinword

# Rehash PATH with every new prompt
hash_precmd() {
    builtin hash -r
}
add-zsh-hook precmd hash_precmd
# }}}


# {{{ Includes
# Local configuration
[ -r ~/.zshrc_local ] && . ~/.zshrc_local || builtin true
[ -r ~/.zshrc_$HOSTNICK ] && . ~/.zshrc_$HOSTNICK || builtin true

# Additional files
[ -r ~/.zalias ] && . ~/.zalias || builtin true
[ -r ~/.zbindkey ] && . ~/.zbindkey || builtin true
# }}}


# {{{ Prompt
# NOTE: Moved to the end of file to ensure prompt_precmd hook is last
prompt blami
# }}}

# vim:set ft=zsh:

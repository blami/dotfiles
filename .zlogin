# ~/.zlogin - Zsh interactive shell login script
# This file is sourced by interactive login shells on login

# Config file loading order:
#             L   N   S   (L=login,N=non-login,S=script)
#   .zshenv   1   1   1
#   .zprofile 2
#   .zshrc    3   2
# * .zlogin   4
#   .zlogout  X

# interactive only
[[ $- != *i* ]] && return

# {{{ Includes
# include _local* versions (except _local.* e.g.: .bak, .swp, etc.) 
for f in ${(%):-%N}_local^.*(rN^/); source $f ; unset f
# }}}

builtin true


# vim:set ft=zsh:

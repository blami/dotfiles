# ~/.zlogout - Zsh interactive shell logout script
# This file is sourced by interactive login shells on logout

# Config file loading order:
#             L   N   S   (L=login,N=non-login,S=script)
#   .zshenv   1   1   1
#   .zprofile 2
#   .zshrc    3   2
#   .zlogin   4
# * .zlogout  X

# interactive only
[[ $- != *i* ]] && return

# last session?
zlogout_last=0 ; for u in ${(f@)"$(who)"} ; \
	[[ $u == $USER\[\[:blank:\]\]* ]] && (( zlogout_last++ ))
[[ $zlogout_last -le 1 ]] && zlogout_last=1 || zlogout_last=

# {{{ Includes
# include _local* versions (except _local.* e.g.: .bak, .swp, etc.) 
for f in ${(%):-%N}_local^.*(rN^/); source $f ; unset f
# }}}

# {{{ Lock
if [[ -n $last_zlogout ]]; then
	pkill -U $UID ssh-agent
	pkill -U $UID gpg-agent
fi
# }}}

# {{{ Cleanup
# clear screen and terminal title
clear
printf "\e]2;\a"
# }}}

builtin true


# vim:set ft=zsh:

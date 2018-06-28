# ~/.profile.d/less.sh - less pager configuration

# {{{ History
LESSHISTSIZE=1000
LESSHISTFILE=$HOME/.lesshst.$HOST
export LESSHISTSIZE
export LESSHISTFILE
# }}}

# TODO Create lessopen/lessclose scripts
unset LESSOPEN
unset LESSCLOSE


# vim:set ft=zsh:

# ~/.zlogout: Z shell logout script


# {{{ Includes
# Local configuration
[ -r $HOME/.zlogout_local ] && . $HOME/.zlogout_local
[ -r $HOME/.zlogout_$HOST ] && . $HOME/.zlogout_$HOST

# Clear exit code (if any optional file doesn't exist)
builtin true
# }}}


# vim:set ft=zsh:

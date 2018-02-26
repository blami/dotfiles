# ~/.zlogin: Z shell login script


# {{{ Includes
# Local configuration
[ -r $HOME/.zlogin_local ] && . $HOME/.zlogin_local
[ -r $HOME/.zlogin_$HOST ] && . $HOME/.zlogin_$HOST

# Clear exit code (if any optional file doesn't exist)
builtin true
# }}}


# vim:set ft=zsh:

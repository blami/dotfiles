# ~/.zlogin: Z shell login script

# {{{ Includes
# Local configuration
[ -r $HOME/.zlogin_local ] && . $HOME/.zlogin_local
[ -r $HOME/.zlogin_$HOSTNICK ] && . $HOME/.zlogin_$HOSTNICK

# Clear exit code (if any optional file doesn't exist)
builtin true
# }}}


# vim:set ft=zsh:

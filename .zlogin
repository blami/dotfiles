# ~/.zlogin: Z shell login script

# Check if there are any unpushed commits in dotfiles (.dfgit)
[ -d $HOME/.dfgit ] && (( $+commands[git] )) && {
    local log=$(git --git-dir ~/.dfgit log \
        -b main --not --remotes \
        --simplify-by-decoration --decorate --oneline)
    [ ! -z $log ] && echo "Un-pushed dotfiles commits:\n$log"
}


# {{{ Includes
# Local configuration
[ -r $HOME/.zlogin_local ] && . $HOME/.zlogin_local
[ -r $HOME/.zlogin_$HOSTNICK ] && . $HOME/.zlogin_$HOSTNICK

# Clear exit code (if any optional file doesn't exist)
builtin true
# }}}


# vim:set ft=zsh:

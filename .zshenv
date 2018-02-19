# ~/.zshenv - Z shell environment
# NOTE This file is sourced as first from scripts, non-login and login shells.
# NOTE Don't use export VAR=value

echo "DEBUG: i am .zshenv"

# {{{ Hostname
[ -z $HOST ] && HOST=$(hostname)
[ -z $HOSTNAME ] && HOSTNAME=$HOST
# }}}


# {{{ OS
# Sets $OS and $OSARCH variables
_uname=$(uname -sm) ; _uname=(${(@s/ /)_uname:l})
OS=$_uname[1]
case "$OS" in
    cygwin*)            OS=cygwin ;;
    linux-android)      OS=android ;;
    darwin*)            OS=macosx ;;
esac
OSARCH=$OS-$_uname[2]
unset _uname
# }}}


# {{{ Umask
# Set umask 002 for uids >=1000 and having their own group
[ $UID -ge 1000 ] && [ $UID -eq $GID ] && umask 002 || umask 022
# }}}


# {{{ Super-user
# If user is not root set $SUDO to 'sudo'
[ $EUID != 0 ] && SUDO=sudo || SUDO=
# }}}


# {{{ Misc environment
EDITOR=vim
VISUAL=vim
PAGER=less
LESSHISTFILE=-
#BROWSER=~/bin/browser

# Irssi variables
IRCNICK='blami'
IRCUSER='blami'

# Debian/Ubuntu development environment
DEBFULLNAME='Ondrej Balaz'
DEBEMAIL='blami@blami.net'

# Color output on MacOS X
CLICOLOR=1
# }}}


# {{{ Profile
# TODO Setup PATH
# TODO Source snippets in ~/.profile.d
# }}}


# {{{ Includes
# Local configuration
[ -r ~/.zshenv_local ] && . ~/.zshenv_local
[ -r ~/.zshenv_$HOST ] && . ~/.zshenv_$HOST

# Clear exit code (if any file doesn't exist)
builtin true
# }}}


# vim:set ft=sh:

# ~/.zprofile - Z shell profile
# NOTE This file is sourced only for login shells

echo "DEBUG: i am .zprofile"

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
umask
# }}}


# {{{ Super-user
# If user is not root set $SUDO to 'sudo'
[ $EUID != 0 ] && SUDO=sudo || SUDO=
# }}}


# {{{ Temporary directory
# NOTE: This is for systems without TMPDIR set from PAM (or without PAM)
# TMPDIR=
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
UBUMAIL='Ondrej Balaz <blami@blami.net>'

# Color output on MacOS X
CLICOLOR=1
# }}}


# {{{ Function path
# Add ~/.zsh to $fpath
fpath=(~/.zsh ~/.zsh/functions $fpath)
# }}}


# {{{ Profile
autoload -Uz pathmunge
# Setup PATH
pathmunge $HOME/bin/$HOST
pathmunge $HOME/bin/$OSARCH
pathmunge $HOME/bin/$OS
pathmunge $HOME/bin

export PATH
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

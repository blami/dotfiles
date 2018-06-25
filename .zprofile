# ~/.zprofile - Z shell profile
# NOTE This file is sourced only for login shells

# {{{ Hostname
[ -z $HOST ] && HOST=$(hostname)
[ -z $HOSTNAME ] && HOSTNAME=$HOST

# TODO Host nickname (no long $HOST in prompt XTerm title)
HOSTNICK=$HOST
# Host status (0-good, 1-bad, unset don't show)
HOSTOK=
export HOSTNICK HOSTOK
# }}}


# {{{ OS
# Sets $OS and $OSARCH variables
_uname=$(uname -smr) ; _uname=(${(@s/ /)_uname:l})
OS=$_uname[1]
case "$OS" in
    cygwin*)            OS=cygwin ;;
    linux-android)      OS=android ;;
    darwin*)            OS=macosx ;;
esac
OSARCH=$OS-$_uname[3]

# Set $WSL=1 if microsoft is detected in kernel release string
# NOTE Matching against lowercase as lowercased above (:l).
WSL=
[ ! -z ${(MS)_uname[2]##microsoft} ] && WSL=1

unset _uname
export OS OSARCH WSL
# }}}


# {{{ Umask
# Set umask 002 for uids >=1000 and having their own group
[ $UID -ge 1000 ] && [ $UID -eq $GID ] && umask 002 || umask 022
# }}}


# {{{ Super-user
# If user is not root set $SUDO to 'sudo'
[ $EUID != 0 ] && SUDO=sudo || SUDO=
export SUDO
# }}}


# {{{ Temporary directory
# NOTE This is for systems without TMPDIR set from PAM (or without PAM)
# }}}


# {{{ Misc environment
EDITOR=vim
VISUAL=vim
PAGER=less
LESSHISTFILE=-
#BROWSER=~/bin/browser
export EDITOR VISUAL PAGER LESSHISTFILE

# Irssi variables
IRCNICK='blami'
IRCUSER='blami'
export IRCNICK IRCUSER

# Debian/Ubuntu development environment
DEBFULLNAME='Ondrej Balaz'
DEBEMAIL='blami@blami.net'
UBUMAIL='Ondrej Balaz <blami@blami.net>'
export DEBFULLNAME DEBEMAIL UBUMAIL

# Color output on MacOS X
CLICOLOR=1
export CLICOLOR
# }}}


# {{{ Profile
autoload -Uz pathmunge
# Setup PATH
pathmunge $HOME/bin/$HOST
pathmunge $HOME/bin/$OSARCH
pathmunge $HOME/bin/$OS
pathmunge $HOME/bin
export PATH

# Source snippets in ~/.profile.d
[ -d ~/.profile.d ] && for s in ~/.profile.d/*.sh; source $s
builtin unset -v s
# }}}


# {{{ Includes
# Local configuration
[ -r ~/.zprofile_local ] && . ~/.zprofile_local
[ -r ~/.zprofile_$HOST ] && . ~/.zprofile_$HOST

# Clear exit code (if any file doesn't exist)
builtin true
# }}}


# vim:set ft=zsh:

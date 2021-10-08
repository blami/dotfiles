# ~/.zprofile - Z shell profile
# NOTE This file is sourced only for login shells

# {{{ Hostname
[ -z $HOST ] && HOST=$(hostname)
[ -z $HOSTNAME ] && HOSTNAME=$HOST

# TODO Host nickname (no long $HOST in prompt XTerm title)
HOSTNICK=${HOST%%.*}
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

# Set $WSL to non-zero (WSL version 1 or 2); use WSL exported variables for
# detection rather than kernel string in uname.
WSL=
if [ ! -z "$WSL_DISTRO_NAME" ]; then
    [ ! -z "$WSL_INTEROP" ] && WSL=2 || WSL=1
fi

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
if [ -z "$TMPDIR" ]; then
    TMPDIR=/tmp
    export TMPDIR
fi
# }}}


# {{{ Misc environment
if (( $+commands[nvim] )); then
    EDITOR=nvim
    VISUAL=nvim
else
    EDITOR=vim
    VISUAL=vim
fi
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

# Screen reader mode (no fancy prompt, per-app settings in nvim, tmux, etc.)
SR=0
export SR
# }}}


# {{{ PATH and profile
autoload -Uz pathmunge

# In WSL remove native Windows paths from PATH first
if [ ! -z "$WSL" ]; then
    PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/[a-z]/' | paste -s -d:)
fi

# Source snippets in ~/.profile.d
[ -d ~/.profile.d ] && for s in ~/.profile.d/*.sh; source $s
builtin unset -v s

# Setup PATH in ~/local
pathmunge $HOME/local/bin
# Setup PATH in ~ always as last component
pathmunge $HOME/bin/$HOSTNICK
pathmunge $HOME/bin/$OSARCH
pathmunge $HOME/bin/$OS
pathmunge $HOME/bin
export PATH
# }}}


# {{{ Includes
# Local configuration
[ -r ~/.zprofile_local ] && . ~/.zprofile_local
[ -r ~/.zprofile_$HOST ] && . ~/.zprofile_$HOST

# Clear exit code (if any file doesn't exist)
builtin true
# }}}


# vim:set ft=zsh:

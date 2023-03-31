# ~/.zprofile - Z shell profile
# NOTE: This file is sourced only for login shells

# {{{ Hostname
[ -z $HOST ] && HOST=$(hostname)
[ -z $HOSTNAME ] && HOSTNAME=$HOST

HOSTNICK=${HOST%%.*}
# Host status (0-good, 1-bad, unset don't show)
HOSTOK=
export HOSTNICK HOSTOK
# }}}


# {{{ OS
# Sets $OS and $OSARCH variables
OS=$OSTYPE
case "$OS" in
    linux*)         OS=linux ;;
    linux-android)  OS=android ;;
    darwin*)        OS=mac ;;
    freebsd*|netbsd*|openbsd*|dragonfly*) OS=bsd ;;
    win32)          OS=win ;;
    msys*|cygwin*)  OS=win ;;
esac
OSARCH=$OS-$(uname -m)

# Set $WSL to non-zero (WSL version 1 or 2); use WSL exported variables for
# detection rather than kernel string in uname.
WSL=
if [ ! -z "$WSL_DISTRO_NAME" ]; then
    [ ! -z "$WSL_INTEROP" ] && WSL=2 || WSL=1
fi
# If WSL is non-zero set some useful variables
if [ -z "$WSL" ]; then
    WSLUSER=
    WSLHOME=
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
# NOTE: This is for systems without TMPDIR set from PAM (or without PAM)
if [ -z "$TMPDIR" ]; then
    # TODO: create safe /tmp/user/$UID if possible?
    TMPDIR=/tmp
fi
TMP=$TMPDIR
export TMP TMPDIR
# }}}


# {{{ Misc environment
(( $+commands[nvim] )) && EDITOR=nvim || EDITOR=vim
VISUAL=$EDITOR
PAGER=less
LESSHISTFILE=-
export EDITOR VISUAL BROWSER PAGER LESSHISTFILE

# Irssi variables
IRCNICK='blami'
IRCUSER='blami'
export IRCNICK IRCUSER

# User (override in ~/.zprofile_local|$HOST)
MYFULLNAME='Ondrej Balaz'
MYEMAIL='blami@blami.net'
export MYFULLNAME MYEMAIL

# Debian/Ubuntu development environment
DEBFULLNAME='Ondrej Balaz'
DEBEMAIL='blami@blami.net'
UBUMAIL='Ondrej Balaz <blami@blami.net>'
export DEBFULLNAME DEBEMAIL UBUMAIL

# Color output on MacOS X
CLICOLOR=1
export CLICOLOR

# Screen reader mode (no fancy prompt, per-app settings in nvim, tmux, etc.)
SCREENREADER=0
export SCREENREADER

# libvirt (qemu) default connect URI (to see root domains)
LIBVIRT_DEFAULT_URI=qemu:///system
export LIBVIRT_DEFAULT_URI
# }}}


# {{{ PATH and profile
autoload -Uz pathmunge

# In WSL remove native Windows paths from PATH first
if [ ! -z "$WSL" ]; then
    PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/[a-z]/' | paste -s -d:)
fi

# Source snippets in ~/.profile.d
for s in ~/.profile.d/*.sh(N) ; source $s
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

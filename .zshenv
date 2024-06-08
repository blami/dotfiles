# ~/.zshenv - Z shell environment
# NOTE: This file is source before everything else and anytime

# Profiler
# Run time ZPROF=1 zsh -i -c exit
if [ -n "${ZPROF+1}" ]; then
    zmodload zsh/zprof
fi

# Don't source systemwide config
unsetopt GLOBAL_RCS
# Don't run compinit on Debian/Ubuntu
skip_global_compinit=1

# Function path (~/.zsh_local, ~/.zsh) and autoload functions
# NOTE $fpath isn't inherited between shells but is needed in .zprofile
# NOTE ~/.zsh_local overrides ~/.zsh
for p in ~/.zsh ~/.zsh_local; do
    local_fpath=($p/**/*(N/) $p)
    for d in $local_fpath; do
        [ -d $d ] || continue
        fpath=($d $fpath)
        for f in $d/*(N-.x:t); autoload -Uz -- $f
    done
done

builtin unset -v p local_fpath d f

# Environment
# This used to be .zshprofile but that does not load with non-login shells
# (e.g. sudo -u USER /usr/bin/zsh).

# ~/.zprofile - Z shell profile
# NOTE: This file is sourced only for login shells

# {{{ Hostname
[ -z $HOST ] && HOST=$(hostname)
[ -z $HOSTNAME ] && HOSTNAME=$HOST
export HOST HOSTNAME

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
    # TODO:
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


# {{{ Kerberos directory
[ ! -d $HOME/.krb5 ] && mkdir -p $HOME/.krb5
chmod 700 $HOME/.krb5
KRB5CCNAME=FILE:$HOME/.krb5/cc
export KRB5CCNAME
# }}}


# {{{ Misc environment
EDITOR=vim
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

# Debian development environment
DEBFULLNAME='Ondrej Balaz'
DEBEMAIL='blami@blami.net'
export DEBFULLNAME DEBEMAIL

# CPU cores (useful with make -j)
CPUS=1
case "$OS" in
    linux)
        CPUS=$(grep '^core id' /proc/cpuinfo | sort -u | wc -l)
        ;;
esac
export CPUS

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


# {{{ PATH cleaning and profile
autoload -Uz pathmunge

# In WSL remove native Windows paths from PATH first
if [ ! -z "$WSL" ]; then
    PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/[a-z]/' | paste -s -d:)
fi

# Source snippets in ~/.profile.d
for s in ~/.profile.d/*.sh(N) ; source $s
builtin unset -v s
# }}}


# {{{ Includes
# Local configuration
[ -r ~/.zshenv_local ] && . ~/.zshenv_local || builtin true
[ -r ~/.zshenv_$HOST ] && . ~/.zshenv_$HOST || builtin true
# }}}


# {{{ Custom PATH
# NOTE: This goes here so it is always in front and not overriden by _local
# Setup PATH in ~/local
pathmunge $HOME/local/bin
# Setup PATH in ~ always as last component
pathmunge $HOME/bin/$HOSTNICK
pathmunge $HOME/bin/$OSARCH
pathmunge $HOME/bin/$OS
pathmunge $HOME/bin
export PATH
# }}}

# vim:set ft=zsh:

# ~/.zshenv - Zsh environment
# This file is _ALWAYS_ sourced as first, contains basic environment.

# Config file loading order:
#             L   N   S   (L=login,N=non-login,S=script)
# * .zshenv   1   1   1
#   .zprofile 2
#   .zshrc    3   2
#   .zlogin   4
#   .zlogout  X

# {{{ General
# do not load system-wide configs and completion
unsetopt global_rcs
skip_global_compinit=1

# NOTE: useful in non-interactive scripts as well
# globbing and expansion
setopt unset                    # consider unset vars "" or 0
setopt extended_glob            # support #,~,^; see: man zshexpn
setopt case_glob                # *Z does not match zsh/
setopt glob_dots                # *g includes .git
setopt nomatch                  # error on no match

# scripting 
setopt short_loops              # short forms of for,repeat,if,select,function
# }}}

# {{{ Path-arrays
# no need to export PATH MANPATH INFOPATH LD_LIBRARY_PATH 
# NOTE: -U=unique, -x=auto-export, T=tie VAR array sep
typeset -U fpath cdpath
typeset -Ux path manpath
typeset -UxT INFOPATH infopath :
typeset -UxT LD_LIBRARY_PATH ld_library_path :
# }}}

# {{{ fpath
# add ~/.zsh{,_local} to fpath, autoload -x functions
for fp in ~/.zsh{,_local}; fpath=($fp{,/**/*(N/)} $fpath); unset fp
autoload -Uz -- ~/.zsh{,_local}/*^.*(N.^x:t)
# NOTE: +x funcs autoloaded in "Includes" section of ~/.zshrc
# }}}

# {{{ Environment
# see always set vars: man zshparam /PARAMETERS SET BY SHELL
# hostname					
HOSTNAME=${HOST%%.*}            # hostname only
[[ $HOST == *.* ]] && DOMAIN=${HOST#.*}
export HOSTNAME DOMAIN

# operating system and architecture
case "${OSTYPE:l}" in
	linux*)           OS=linux ;;
	darwin*)          OS=macos ;;
        *bsd*|dragonfly*) OS=bsd ;;
	solaris*)         OS=solaris ;;
        haiku*)           OS=haiku ;;
	cygwin*|msys*)    OS=win ;;
	*)                OS="${${OSTYPE:l}%%[0-9.]#}"
esac
case "${CPUTYPE:l}" in
        i386|x86)         ARCH=i386 ;;
	amd64|x86_64|x64) ARCH=amd64 ;;
        arm64|aarch64)    ARCH=arm64 ;;
	*)                ARCH=${CPUTYPE:l} ;;
esac
OSARCH=$OS-$ARCH
export OS ARCH OSARCH

# initial path, manpath and infopath
path=(/usr/local/sbin /usr/sbin /sbin /usr/local/bin /usr/bin /bin $path)
manpath=(/usr/local/share/man /usr/share/man $manpath)
infopath=(/usr/local/share/info /usr/share/info $infopath)

# thread count (make -J $JOBS) 
case "$OS" in
	linux)            JOBS=$(nproc --all 2>/dev/null || echo 1) ;;
        macos|bsd)        JOBS=$(sysctl -n hw.ncpu 2>/dev/null || echo 1) ;;
        *)                JOBS=1 ;;
esac
export JOBS

# systemd and wsl
if [[ $OS == linux ]]; then
	[[ $(readlink -f /proc/1/exe) == */systemd ]] && SYSTEMD=1 
	[[ -n $WSL_DISTRO_NAME ]] && { [[ -n $WSL_INTEROP ]] && WSL=2 || WSL=1 }
fi
# NOTE: for WSL_* see ~/.zshenv.d/10wsl
export SYSTEMD WSL

# temp dir
if [[ -z $TMPDIR ]]; then
	TMPDIR=/tmp/user/$UID
	mkdir -p -m 700 $TMPDIR 2>/dev/null || TMPDIR=/tmp 
fi 
TMP=$TMPDIR
TEMP=$TMPDIR
TEMPDIR=$TMPDIR
export TMPDIR TMP TEMP TEMPDIR

# XDG directories
# SEE: https://specifications.freedesktop.org/basedir-spec/latest/
# NOTE: to use XDG dirs in scripts even if not set by OS/pam/systemd
# NOTE: XDG data dirs are set in ~/.zshenv.d/10xdg 
# runtime dirs
XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$TMPDIR}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
# config dirs
XDG_CONFIG_HOME=$HOME/.config
XDG_CONFIG_DIRS=/etc/xdg
XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_RUNTIME_DIR XDG_CACHE_DIR XDG_DATA_HOME XDG_STATE_HOME \
	XDG_CONFIG_HOME XDG_CONFIG_DIRS XDG_DATA_DIRS
# }}}

# {{{ Misc
# umask
[[ $UID -ge 1000 && $UID -eq $GID ]] && umask 002 || umask 022
# }}}

# interactive-only shell environment
# NOTE: this is guard so that includes can be last and in interactive shell
# rely on variables set here.
if [[ $- == *i* ]]; then

# {{{ Environment
# id
NAME='Ondrej Balaz'
EMAIL='blami@blami.net'
NICK='blami'
GPGKEY='1FCD8C25'
DEBFULLNAME=$NAME
DEBEMAIL=$EMAIL
IRCNICK=$NICK
IRCUSER=$IRCNICK
export NAME EMAIL NICK GPGKEY DEBFULLNAME DEBEMAIL IRCNICK IRCUSER

# basics
EDITOR=vim
VISUAL=$EDITOR
PAGER=less
MANPAGER=$PAGER
DIFFPROG=vimdiff
GREP=grep
BROWSER=$HOME/bin/browser
export EDITOR VISUAL PAGER MANPAGER LESS DIFFPROG GREP

# defaults
# less
LESS=-iRQM                      # case insensitive, colors, quiet and prompts
LESSHISTFILE=-                  # do not store less history
# NOTE: color settings are in ~/.zshenv.d/80colors
export LESS LESSHISTFILE
# xz
XZ_DEFAULTS='--threads=0'
export XZ_DEFAULTS

# sudo (for use in .zalias, vimrc, etc.)
[[ $EUID != 0 ]] && SUDO=sudo || SUDO=
export SUDO
# }}}

fi # [[ $- == *i* ]]

# {{{ Includes
# load snippets in ~/.zshenv.d/* (except .* e.g: .bak, .swp, .old)
for f in $HOME/.zshenv.d/^*.*(rN^/); source $f 
# include _local* versions (except _local.* e.g.: .bak, .swp, etc.) 
for f in ${(%):-%N}_local^.*(rN^/); source $f
unset f
# }}}

# {{{ Path
# prepend path with $HOME/{bin,.local/bin}
path=($HOME/{bin,.local/bin} $path)
# }}}

builtin true


# vim:set ft=zsh:

# ~/.profile.d/mc.sh: Midnight Commander wrapper

[ -n "${BASH_VERSION}${KSH_VERSION}${ZSH_VERSION}" ] || return 0
alias mc='. /usr/lib/mc/mc-wrapper.sh'

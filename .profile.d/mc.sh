# ~/.profile.d/mc.sh - Midnight Commander wrapper

[ -n "${BASH_VERSION}${KSH_VERSION}${ZSH_VERSION}" ] || return 0

for D in /usr/lib /usr/libexec ; do
	[ -r $D/mc/mc-wrapper.sh ] && alias mc=". $D/mc/mc-wrapper.sh"
done

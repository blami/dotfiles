# ~/.profile.d/ccache.sh: Use ccache by default
# Uses pathmunge() from ~/.sh_profile

if [ -d /usr/lib/ccache ]; then

pathmunge "/usr/lib/ccache" after
export PATH

if [ -n "${CCACHE_DIR:-}" ] ; then
	if [ ! -w "$CCACHE_DIR" ] ; then
		unset CCACHE_DIR
		unset CCACHE_UMASK
	fi
elif [ "${EUID:-}" != 0 ] ; then
	if [ -w /var/cache/ccache ] && [ -d /var/cache/ccache ] ; then
		export CCACHE_DIR=/var/cache/ccache
		export CCACHE_UMASK=002
		unset CCACHE_HARDLINK
	fi
fi

export CCACHE_HASHDIR=

fi

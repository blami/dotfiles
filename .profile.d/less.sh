# ~/.profile.d/less.sh: Read from lesspipe

if [ -x /usr/bin/lesspipe.sh ]; then
	LESSOPEN="${LESSOPEN-||/usr/bin/lesspipe.sh %s}" ; export LESSOPEN
fi

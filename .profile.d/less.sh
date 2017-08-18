# ~/.profile.d/less.sh - less pager configuration

# History
if [ -d $HOME/.history ]; then
    LESSHISTSIZE=1000
    LESSHISTFILE=~/.history/lesshst.$HOST

    export LESSHISTSIZE
    export LESSHISTFILE
fi

# TODO Create lessopen/lessclose scripts
unset LESSOPEN
unset LESSCLOSE

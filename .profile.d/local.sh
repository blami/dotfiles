# ~/.profile.d/local.sh - ~/local/$OSARCH local builds directory
# NOTE: This uses pathmunge

# I use this in environments where I'm ordinary user only and want to add some
# software I need to hand compile.

LOCAL_DIR="$HOME/local/$OSARCH"

# Add binary directories to PATH
[ -d $LOCAL_DIR/bin ] && pathmunge $LOCAL_DIR/bin
[ -d $LOCAL_DIR/sbin ] && pathmunge $LOCAL_DIR/sbin

# Setup some useful variables
LOCAL_LDFLAGS=-L$LOCAL_DIR/lib
LOCAL_CFLAGS=-I$LOCAL_DIR/include
LOCAL_CPPFLAGS=-I$LOCAL_DIR/include

export LOCAL_LDFLAGS LOCAL_CFLAGS LOCAL_CPPFLAGS LOCAL_DIR


# vim:set ft=zsh:

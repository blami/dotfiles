# Golang environment
# NOTE: This uses pathmunge

# Set GOPATH to $HOME/.local/go
# NOTE: $GOPATH I still love you (but only) for installing tools
[ -d $HOME/.local/go ] || mkdir -p $HOME/.local/go/bin
GOPATH=$HOME/.local/go

# NOTE: On systems where I don't have root I tend to merge $GOROOT and $GOPATH
for goroot in "$GOPATH" \
    "$HOME/.local/$OSARCH/go" \
    "/opt/google/go" \
    "/cygdrive/c/devel/go"; do

    if [ -d "$goroot" ]; then
        pathmunge $goroot/bin after
        export PATH
        break
    fi
done
unset -v goroot
export GOPATH PATH

# Set GO111MODULE to auto (use go.mod if exists)
GO111MODULE=auto
export GO111MODULE


# vim:set ft=zsh:

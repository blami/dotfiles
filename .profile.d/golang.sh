# Golang environment
# NOTE: This uses pathmunge

# Set GOPATH to $HOME/.local/go
# NOTE: $GOPATH I still love you (but only) for installing tools
[ -d $HOME/.local/go ] || mkdir -p $HOME/.local/go/bin
GOPATH=$HOME/.local/go

for goroot in "$GOPATH" \
    "$HOME/.local/$OSARCH/go" \
    "/usr/local/go" \
    "/opt/go" ; do

    if [ -d "$goroot/bin" ]; then
        pathmunge $goroot/bin after
        export PATH
    fi
done
unset -v goroot
export GOPATH PATH

# Set GO111MODULE to auto (use go.mod if exists)
GO111MODULE=auto
export GO111MODULE


# vim:set ft=zsh:

# ~/.profile.d/golang.sh - Setup golang environment
# NOTE: This uses pathmunge

for goroot in "$HOME/.local/go" \
    "$HOME/.local/$OSARCH/go" \
    "/opt/google/go" \
    "/cygdrive/c/devel/go"; do

    if [ -d "$goroot" ]; then
        pathmunge $goroot/bin after
        export PATH
        break
    fi
done
builtin unset -v goroot

# Set GOPATH to $HOME/go
# NOTE: GOPATH I still love you for installing tools
GOPATH=$HOME/go
[ -d "$GOPATH/bin" ] && pathmunge $GOPATH/bin after
export GOPATH PATH

# Set GO111MODULE to auto (use go.mod if exists)
GO111MODULE=auto
export GO111MODULE


# vim:set ft=zsh:

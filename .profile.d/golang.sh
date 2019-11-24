# ~/.profile.d/golang.sh - Setup golang environment
# NOTE: This uses pathmunge

for goroot in "$HOME/.local/go" \
    "/opt/google/go" \
    "/cygdrive/c/devel/go"; do

    if [ -d "$goroot" ]; then
        pathmunge $goroot/bin after
        export PATH
        break
    fi
done
builtin unset -v goroot

# Set GOPATH to $HOME/ws/go
GOPATH=$HOME/ws/go
[ -d "$GOPATH/bin" ] && pathmunge $GOPATH/bin after
export GOPATH PATH

# Set GO111MODULE to auto (use go.mod if exists)
GO111MODULE=auto
export GO111MODULE


# vim:set ft=zsh:

# ~/.profile.d/golang.sh - Setup golang environment
# NOTE: This uses pathmunge

for goroot in "$HOME/.local/go" \
    "/opt/google/go" \
    "/cygdrive/c/devel/go"; do

    [ -d "$goroot" ] && pathmunge $goroot/bin after
done
builtin unset -v goroot


# vim:set ft=zsh:

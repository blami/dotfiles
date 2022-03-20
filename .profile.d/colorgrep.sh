# ~/.profile.d/colorgrep.sh - Colorize GNU grep output

# Skip configuration for non-interactive shells
[ -z "$PS1" ] && return
# Force disable colors
[ ! -z "$NO_COLORGREP" ] && return

# Load colors
GREP_COLORS=
for colors in "$HOME/.GREP_COLORS.$TERM" \
    "$HOME/.GREP_COLORS" \
    "/etc/GREP_COLORS.$TERM" \
    "/etc/GREP_COLORS"; do

    [ -r $colors ] && GREP_COLORS=$(cat $colors | head -n1) && break
done
unset -v colors

[ -z "$GREP_COLORS" ] && return
export GREP_COLORS


# vim:set ft=zsh:

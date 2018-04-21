# ~/.profile.d/colorls.sh - Colorize ls output

# Skip configuration for non-interactive shells
[ -z "$PS1" ] && return
# Disable colors
[ ! -z "$NO_COLORLS" ] && return

# Load colors
COLORS=
for colors in "$HOME/.DIR_COLORS.$TERM" \
    "$HOME/.DIR_COLORS" \
    "/etc/DIR_COLORS.$TERM" \
    "/etc/DIR_COLORS"; do

    [ -r "$colors" ] && COLORS="$colors" && break
done

if [ -n "$COLORS" ]; then
    # Eval selected file and set alias
    eval "`dircolors --sh "$COLORS" 2>/dev/null`"
    unset COLORS
    [ -z "$LS_COLORS" ] && return

    export LS_COLORS

    # If shell is Zsh export also ZLSCOLORS
    [ -n $ZSH_VERSION ] && export ZLSCOLORS=$LS_COLORS
fi

# ~/.profile.d/colorless.sh - Colorize less output

# Skip configuration for non-interactive shells
[ -z "$PS1" ] && return
# Disable colors
[ ! -z "$NO_COLORLESS" ] && return

# Source less colors
for colors in "$HOME/.LESS_COLORS.$TERM" \
	"$HOME/.LESS_COLORS" \
	"/etc/LESS_COLORS.$TERM" \
	"/etc/LESS_COLORS"; do

	[ -r "$colors" ] && source $colors && break
done
builtin unset -v colors


# vim:set ft=zsh:

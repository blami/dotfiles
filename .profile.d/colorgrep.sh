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

if [ ! -z "$GREP_COLORS" ]; then
	for grep in "grep" "egrep" "fgrep" \
		"ggrep" "gegrep" "gfgrep"; do

		type $grep >/dev/null 2>&1 || continue
		# Only GNU grep
		[ -z "$($grep -V 2>/dev/null | head -n1 | grep GNU)" ] && continue
		alias $grep="$grep --color=auto" 2>/dev/null
	done

	export GREP_COLORS
fi

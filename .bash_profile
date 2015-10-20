# ~/.bash_profile: bash resource file
# NOTE: this file is sourced by login shells

# {{{ ZSH
# NOTE: use ZSH on systems where available but not set as a default shell.
if [ -z "$ZSH_VERSION" ]; then
	# TODO Find zsh
	zsh_exec=
	zsh_args="-l"
	[ -x /bin/zsh ] && zsh_exec=/bin/zsh
	if [ -n "$zsh_exec" ]; then
		case $- in
			*i*) SHELL=$zsh_exec; export SHELL; exec "$zsh_exec" "$zsh_args" ;;
		esac
	fi
fi
# }}}


# Source .bashrc to have same environment in login and non-login shells
source $HOME/.bashrc

# ~/.zshrc - Zsh interactive shell configuration
# This file is sourced by interactive login and non-login shells

# Config file loading order:
#             L   N   S   (L=login,N=non-login,S=script)
#   .zshenv   1   1   1
#   .zprofile 2
# * .zshrc    3   2
#   .zlogin   4
#   .zlogout  X
#

# interactive only
[[ $- != *i* ]] && return

# {{{ General
# NOTE: see also .zshenv for setopts relevant to non-interactive shells
# globbing and expansion
setopt mark_dirs                # add / to dirs

# redirection
setopt noclobber clobber_empty  # do not > overwrite non-empty files
setopt multios                  # allow cmd >foo >bar |baz 

# commands
setopt path_dirs                # look for foo/bar in $PATH/foo/bar
setopt hash_cmds hash_dirs      # hash cmds and dirs to avoid PATH lookups
precmd() {
	builtin hash -r         # rehash cmds (add to PATH) on every prompt
}

# changing directories
unsetopt auto_cd
unsetopt chase_dots chase_links # do not resolve .. and symlinks while cd
setopt auto_pushd pushd_ignore_dups # push to dirstack on cd
setopt pushd_to_home            # pushd==pushd ~

# scripting
setopt interactive_comments
#setopt c_bases                 # use 0x instead of 16# 

# i/o
[[ $(locale LC_CTYPE) == UTF-8 ]] && setopt combining_chars
# }}}

# {{{ Jobs
#setopt long_list_jobs          # job list long format (default)
setopt auto_continue            # auto-continue after bg && disown
unsetopt bg_nice                # do not auto-nice bg jobs
setopt check_jobs check_running_jobs # report bg jobs before exit
unsetopt hup                    # do not HUP bg jobs on exit
REPORTMEMORY=524288             # report jobs mem>512MB
REPORTTIME=60                   # report jobs user+sys>1min
TIMEFMT="%J %*Es  user:%U sys:%S cpu:%P mem:%MkB"
# }}}

# {{{ Prompt
PROMPT_EOL_MARK='%'             # mark missing newline
autoload -Uz promptinit
setopt prompt_subst
setopt transient_rprompt
promptinit
#prompt blami
# }}}

# {{{ Completion
unsetopt correct
setopt complete_in_word
unsetopt list_packed           # columns of different width
setopt list_types              # file types
# TODO is it possible to use completion only with own snippets in ~?
# }}}

# {{{ History
HISTFILE=~/.zsh_history.$HOST
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history         # save in : start:elapsed:command format
setopt hist_ignore_all_dups hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space        # do not store commands starting with ' '
setopt hist_reduce_blanks
setopt share_history            # implies inc_append_history(_time)
# ignore patterns (depends on setopt extended_glob)
HISTORY_IGNORE="(ex[io]t|:q|:wq|reset|rst|clear|cls|pwd|(l[salt.dON]|cd|less|t|tree|b[gf]|jobs|j|disown|fc|history|h|pushd|popd|git st|git status|git lo[gl]|git lola)#( *)#|tmux|* --help|man *)"
zshaddhistory() {
	emulate -L zsh
	setopt extended_glob
	[[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}
# }}}

# {{{ Misc
unsetopt beep list_beep         # do not beep
# mail
unsetopt mail_warning
MAILCHECK=
# }}}

# {{{ Includes
# include _local* versions (except _local.* e.g.: .bak, .swp, etc.) 
for f in ${(%):-%N}_local^.*(rN^/); source $f ; unset f
# autoload +x functions
[[ $- == *i* ]] && autoload -Uz -- ~/.zsh{,_local}/*^.*(N.x:t) >/dev/null
# NOTE: -x funcs autoloaded in "fpath" section of ~/.zshenv
# other includes
[ -r $HOME/.zalias ] && source $HOME/.zalias || true
[ -r $HOME/.zbindkey ] && source $HOME/.zbindkey || true
# }}}

builtin true


# vim:set ft=zsh:

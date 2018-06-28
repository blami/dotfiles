# ~/.zshenv - Z shell environment
# NOTE This file is source before everything else and anytime


# {{{ Distro-specific toggles
# Don't run compinit on Debian/Ubuntu
skip_global_compinit=1
# }}}


# {{{ Function path
# NOTE $fpath doesn't inherit between shells. I use my funcs in zprofile too.
# Add ~/.zsh to $fpath
fpath=(~/.zsh ~/.zsh/funcs $fpath)
# Autoload all functions in files marked as executable
for f in ~/.zsh/funcs/*(N-.x:t); autoload -Uz -- $f
builtin unset -v f
# }}}

# ~/.zshenv - Z shell environment
# NOTE This file is source before everything else and anytime


# {{{ Distro-specific toggles
# Don't run compinit on Debian/Ubuntu
skip_global_compinit=1
# }}}


# {{{ Function path
# NOTE $fpath doesn't inherit between shells but needed in .zprofile

# Add ~/.zsh_local and ~/.zsh to $fpath and autoload functions
# NOTE Make sure directories are in opposite order
for p in ~/.zsh ~/.zsh_local; do
    for d in "$p/zle" "$p/funcs" "$p"; do
        [ -d $d ] || continue
        fpath=($d $fpath)
        for f in ~/.zsh/funcs/*(N-.x:t); autoload -Uz -- $f
    done
done

builtin unset -v f
# }}}

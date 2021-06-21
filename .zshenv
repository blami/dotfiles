# ~/.zshenv - Z shell environment
# NOTE This file is source before everything else and anytime

# Don't source systemwide config
unsetopt GLOBAL_RCS
# Don't run compinit on Debian/Ubuntu
skip_global_compinit=1

# Function path (~/.zsh_local, ~/.zsh) and autoload functions
# NOTE $fpath isn't inherited between shells but is needed in .zprofile
# NOTE ~/.zsh_local overrides ~/.zsh
for p in ~/.zsh ~/.zsh_local; do
    local_fpath=($p/**/*(N/) $p)
    for d in $local_fpath; do
        [ -d $d ] || continue
        fpath=($d $fpath)
        for f in $d/*(N-.x:t); autoload -Uz -- $f
    done
done

builtin unset -v p local_fpath d f

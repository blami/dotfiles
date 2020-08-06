# ~/.zshenv - Z shell environment
# NOTE This file is source before everything else and anytime

# Don't run compinit on Debian/Ubuntu
skip_global_compinit=1

# Function path (~/.zsh_local, ~/.zsh) and autoload functions
# NOTE $fpath doesn't inherit between shells but needed in .zprofile
# Add ~/.zsh_local and ~/.zsh to $fpath and autoload functions
# NOTE Make sure directories are in opposite order
for p in ~/.zsh ~/.zsh_local; do
    local_fpath=($p/**/*(N/) $p)
    for d in $local_fpath; do
        [ -d $d ] || continue
        fpath=($d $fpath)
        for f in $d/*(N-.x:t); echo $f && autoload -Uz -- $f
    done
done

builtin unset -v p local_fpath d f

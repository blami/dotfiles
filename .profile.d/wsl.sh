# WSL related environment
# NOTE: This uses pathmunge

if [ ! -z "$WSL" ]; then

# Export some useful variables
WINUSER=
WINHOME=

# Add ~/bin/wsl to PATH
[ -d ~/bin/wsl ] && pathmunge ~/bin/wsl after

# Add Windows utilities (e.g. fsutil.exe, wslconf.exe...) to PATH
for dir in "/mnt/c/Windows/System32" \
    "/mnt/c/Windows" \
    "/mnt/c/Windows/System32/wbem" \
    "/mnt/c/Windows/System32/WindowsPowerShell/v1.0" \
    "$HOME/AppData/Local/Microsoft/WindowsApps"; do

    [ -d $dir ] && pathmunge $dir after
done

# Add development tools in C:\Devel to PATH
# NOTE: This is generally safe as Windows binaries must be executed with .exe
for dir in "/mnt/c/Devel/python3" \
    "/mnt/c/Devel/python/Scripts" \
    "/mnt/c/Devel/go/bin" \
    "/mnt/c/Devel/node/bin" \
    "/mnt/c/Devel/llvm/bin" \
    "/mnt/c/Devel/cmake/bin" ; do

    [ -d $dir ] && pathmunge $dir after
done

unset -v dir
fi


# vim:set ft=zsh:

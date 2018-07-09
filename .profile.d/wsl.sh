# ~/.profile.d/wsl.sh - WSL related environment
# NOTE: This uses pathmunge
# NOTE: This also expects $HOME to be same as Windows user %HOME%

if [ ! -z "$WSL" ]; then
# Add Windows utilities (e.g. fsutil, wslconf...) to PATH
for dir in "/mnt/c/Windows/System32" \
    "/mnt/c/Windows" \
    "/mnt/c/Windows/System32/wbem" \
    "/mnt/c/Windows/System32/WindowsPowerShell/v1.0" \
    "$HOME/AppData/Local/Microsoft/WindowsApps"; do

    [ -d $dir ] && pathmunge $dir after
done
builtin unset -v dir
fi


# vim:set ft=zsh:

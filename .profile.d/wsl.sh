# WSL related environment
# NOTE: This uses pathmunge
# NOTE: This also uses wslpath

[ -n "$WSL" ] || return

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

# Export some useful variables
typeset -A winenv
winenv=($(powershell.exe -Command 'Write-Host `
    "OS" $env:OS `
    "OSVER" $([System.Environment]::OSVersion).Version.Major `
    "COMPUTERNAME" $env:COMPUTERNAME `
    "USERNAME" $env:USERNAME `
    "USERDOMAIN" $env:USERDOMAIN `
    "USERPROFILE" $env:USERPROFILE
    '))

WINUSER=${winenv[USERNAME]}
WINDOMAIN=${winenv[USERDOMAIN]}
WINHOME=$(wslpath -u "${winenv[USERPROFILE]}")
WINVER=${winenv[OSVER]}
export WINUSER WINDOMAIN WINHOME WINVER

unset -v winenv


# vim:set ft=zsh:

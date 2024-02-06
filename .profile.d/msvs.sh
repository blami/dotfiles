# Microsoft Visual Studio (not Code) environment for WSL.
# NOTE: This uses pathmunge

# TODO: See https://unix.stackexchange.com/questions/219314/best-way-to-make-variables-local-in-a-sourced-bash-script
# to hide some variables

[ -n "$WSL" ] || return

MSVSARCH=${MSVSARCH:-amd64}
MSVSINST="/mnt/c/Program Files (x86)/Microsoft Visual Studio"

[ -d "$MSVSINST" ] || return

MSVSDIR=$("$MSVSINST"/Installer/vswhere.exe -latest -property installationPath)
MSVSDIR=${MSVSDIR%$'\r'}
[ -n "$MSVSDIR" ] || return

# BUG: This takes relatively long time to do so cache in ~/.msvs.env?
#[ -r ~/.msvs.env ] 

# Run vcvarsall.bat and store environment
# NOTE: In case vcvarsall.bat is not installed output will be empty 2>/dev/null
typeset -A vars
while IFS= read -r var ; do
    vars[${var%=*}]=${var##*=}
done <<<"$(cd /mnt/c && /mnt/c/Windows/System32/cmd.exe /C "$MSVSDIR\\VC\\Auxiliary\\Build\\vcvarsall.bat $MSVSARCH && set" 2>/dev/null || return)"

MSVSKITDIR=${vars[WindowsSdkDir]%$'\r'}

# MSVC
INCLUDE=${vars[INCLUDE]%$'\r'}
EXTERNAL_INCLUDE=${vars[EXTERNAL_INCLUDE]%$'\r'}
LIBPATH=${vars[LIBPATH]%$'\r'}
LIB=${vars[LIB]%$'\r'}

# Path
# NOTE: Only append MSVC/Windows Kits related paths
while IFS=\; read -d\; -r dir; do
    [[ $dir == $MSVSDIR* ]] || [[ $dir == $MSVSKITDIR* ]] || continue
    pathmunge $(wslpath -u $dir) after
done <<<"${vars[Path]}"

WSLENV=$WSLENV:INCLUDE/w:EXTERNAL_INCLUDE/w:LIB/w:LIBPATH/w
export WSLENV INCLUDE EXTERNAL_INCLUDE LIB LIBPATH

#unset -f vcvarsall


# vim:set ft=zsh:

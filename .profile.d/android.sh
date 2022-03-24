# ~/.profile.d/android.sh - Setup Android SDK environment
# NOTE: This uses pathmunge

for androidroot in "$HOME/.local/android" \
    "$HOME/.local/$OSARCH/android" \
    "/opt/google/android" \
    "/cygdrive/c/devel/android"; do

    if [ -d "$androidroot" ]; then
        pathmunge $androidroot/tools after
        pathmunge $androidroot/tools/bin after

        # NOTE for Cygwin convert ANDROID_HOME to Windows path
        ANDROID_HOME=$androidroot
        export ANDROID_HOME
        # Break on first found
        break
    fi
done
unset -v androidroot


# vim:set ft=zsh:

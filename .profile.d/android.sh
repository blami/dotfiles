# ~/.profile.d/android.sh - Setup Android SDK environment
# NOTE: This uses pathmunge from ~/.sh_profile

for androidroot in "$HOME/.local/android" \
    "/opt/google/android" \
    "/cygdrive/c/devel/android"; do

    if [ -d "$androidroot" ]; then 
        pathmunge $androidroot/tools after
        pathmunge $androidroot/tools/bin after

        # NOTE for cygwin convert ANDROID_HOME to Windows path
        ANDROID_HOME=$androidroot
        export ANDROID_HOME
    fi
done

# vim:set ft=zsh:

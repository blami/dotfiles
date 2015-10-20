# ~/.profile.d/android.sh: Add Android platform-tools to PATH
# Uses pathmunge() from ~/.sh_profile

pathmunge "/opt/google/android/platform-tools" after
export PATH

NO_AT_BRIDGE=1 ; export NO_AT_BRIDGE

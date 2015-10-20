# ~/.profile.d/go.sh: Golang environment
# Uses pathmunge() from ~/.sh_profile

if [ -d "/opt/go/bin" ]; then

pathmunge "/opt/go/bin" after
export PATH

GOROOT=/opt/go ; export GOROOT
# TODO GOPATH

fi

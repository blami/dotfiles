# Docker environment

# In WSL1 just connect to Windows Docker daemon over TCP
if [ "$WSL" -eq 1 ]; then
    DOCKER_HOST=127.0.0.1:2375
    export DOCKER_HOST
fi


# vim:set ft=zsh:

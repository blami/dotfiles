# ~/.profile.d/docker.sh - Docker client environment

# In WSL1 just connect to Windows Docker daemon over TCP
if [ "$WSL" -eq 1 ]; then
    DOCKER_HOST=127.0.0.1:2375
    #DOCKER_TLS_VERIFY=1
    #DOCKER_CERT_PATH=/mnt/C/ProgramData/docker/certs.d

    export DOCKER_HOST #DOCKER_TLS_VERIFY DOCKER_CERT_PATH
fi


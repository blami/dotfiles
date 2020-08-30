# ~/.profile.d/ssh_agent.sh - SSH agent on startup

SSH_AGENT=ssh-agent
SSH_AGENT_ENV=$HOME/.ssh/agent/$HOST.env

# Read given $1 variable form agent env file
function ssh_agent_readenv {
    sed -n "s/^$1=\([^\;]*\);.*$/\1/p" "$SSH_AGENT_ENV"
}

# Start agent, dump env file and set variables
function ssh_agent {
    $SSH_AGENT -s > "$SSH_AGENT_ENV"
    chmod 600 "$SSH_AGENT_ENV"
    SSH_AUTH_SOCK=$(ssh_agent_readenv "SSH_AUTH_SOCK")
    SSH_AGENT_PID=$(ssh_agent_readenv "SSH_AGENT_PID")
}

[ -d $HOME/.ssh/agent ] || mkdir -p $HOME/.ssh/agent
if [ -f "${SSH_AGENT_ENV}" ]; then
    # Read safely SSH_AUTH_SOCK and SSH_AGENT_PID
    SSH_AUTH_SOCK=$(ssh_agent_readenv "SSH_AUTH_SOCK")
    SSH_AGENT_PID=$(ssh_agent_readenv "SSH_AGENT_PID")

    # Check whether agent is still runing
    # NOTE This is ugly but it works on Linux/Cygwin/MacOS
    ps -ef | grep "^$USER\s\+$SSH_AGENT_PID.*ssh-agent .*$" > /dev/null || \
        ssh_agent
else
    ssh_agent
fi

unset -f ssh_agent_readenv
unset -f ssh_agent

# Export variables
export SSH_AUTH_SOCK SSH_AGENT_PID SSH_AGENT_ENV

# vim:set ft=zsh:

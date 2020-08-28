#!/bin/bash
# Print tmux status bar in format
#
#  .- host (HOSTNICK if set)
#  |   .- SSH connection
#  |   |
#  v   v
# host[>] 23:55 31w12

# {{{ Hostname
host=${HOSTNICK:-$HOST}
[ -z "$SSH_CONNECTION" ] || host="$host>"
# }}}

# Print date in same format as 'blami' Zsh prompt uses
# Day of week
DOW=umtwhfs ; DOW=${DOW:$(date +%w):1}
# Delimiter
DLM=:
timedate=$(date +"%H${DLM}%M %d${DOW}%m")


echo $host $timedate

#!/bin/bash
# Print date in same format as 'blami' Zsh prompt uses

# Day of week
DOW=umtwhfs ; DOW=${DOW:$(date +%w):1}
# Delimiter
DLM=:

echo $(date +"%H${DLM}%M %d${DOW}%m")

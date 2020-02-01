# ~/.profile.d/node.sh - Node.js related environment
# NOTE: This uses pathmunge

# Add ~/.node/bin to PATH
[ -d ~/.node/bin ] && pathmunge ~/.node/bin after
[ -d ~/.yarn/bin ] && pathmunge ~/.yarn/bin after

# Add ~/.node to NODE_PATH
NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"
export NODE_PATH


# vim:set ft=zsh:

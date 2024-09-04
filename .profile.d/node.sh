# Node.js related environment
# NOTE: This uses pathmunge

# Add ~/.local/node/bin to PATH
[ -d $HOME/.local/nodejs/bin ] || mkdir -p $HOME/.local/nodejs/bin
pathmunge ~/.local/nodejs/bin after

# Add ~/.local/node to NODE_PATH
NODE_PATH="$HOME/.local/nodejs/lib/node_modules:$NODE_PATH"
export NODE_PATH


# vim:set ft=zsh:

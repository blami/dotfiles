# Node.js related environment
# NOTE: This uses pathmunge

# Add ~/.local/node/bin to PATH
[ -d $HOME/.local/node/bin ] || mkdir -p $HOME/.local/node/bin
pathmunge ~/.local/node/bin after

# Add ~/.local/node to NODE_PATH
NODE_PATH="$HOME/.local/node/lib/node_modules:$NODE_PATH"
export NODE_PATH


# vim:set ft=zsh:

# ~/.profile.d/vim.sh: Use vim instead of vi

if [ -n "${BASH_VERSION}${KSH_VERSION}${ZSH_VERSION}" ]; then
	alias vi=vim
fi

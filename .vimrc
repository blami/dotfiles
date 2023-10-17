" Load .vimrc from ~/.vim/vimrc if it exists

"Use ~/.vim instead of vimfiles on Windows
if has('win32')
    set rtp^=$HOME/.vim
    set rtp+=$HOME/.vim/after
endif

source $HOME/.vim/vimrc

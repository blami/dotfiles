" Load .vimrc from ~/.vim/vimrc if it exists
if filereadable(expand("$HOME") . "/.vim/vimrc")
    source $HOME/.vim/vimrc
endif

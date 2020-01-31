" .vimrc - Vim configuration

" NOTE this file loads ~/.vim/vimrc to avoid direct symlink which can't
" be used on Windows

" Use ~/.vim instead of vimfiles on Windows
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

source $HOME/.vim/vimrc

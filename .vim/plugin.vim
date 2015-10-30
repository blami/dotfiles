" ~/.vim/vundle: Vim bundles managed by Vundle

"filetype off                               " See ~/.vim/vimrc

" Check if vundle is installed
let s:vundle_clone = 0
if !filereadable(expand('$HOME/.vim/bundle/Vundle.vim/autoload/vundle.vim'))
    exec '!git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim'
    let s:vundle_clone = 1
endif
set runtimepath+=$HOME/.vim/bundle/Vundle.vim


" {{{ Enabled plugins
" NOTE: Plugin configuration follows the plugin stanza
call vundle#begin()
" Vundle
Plugin 'VundleVim/Vundle.vim'

" Language
Plugin 'fatih/vim-go'                       " Go support
Plugin 'nvie/vim-flake8'                    " Python PEP8/Flake/Complexity

" Autocompletion
"Plugin 'Valloric/YouCompleteMe'             " Complex auto-completion
if v:version > 704
    Plugin 'SirVer/ultisnips'               " Filetype-based snippets
endif
Plugin 'ctrlpvim/ctrlp.vim'                 " Fuzzy file/buffer finder

call vundle#end()
" }}}


" Install vundle bundles after installation
if s:vundle_clone == 1
    PluginInstall
endif


" vim:set ft=vim fo-=t:

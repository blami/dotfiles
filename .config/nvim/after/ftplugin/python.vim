" Language: Python
" Maintainer: Ondrej Balaz

" Neovim/plugin ftplugins are disabled. See autocmd.vim.
"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

" PEP8 Indentation
setl expandtab shiftwidth=4 softtabstop=4 tabstop=8

" Comments
setl comments=b:#,fb:-
setl commentstring=#\ %s
" Don't re-indent # comments
setl cinkeys-=0#
setl indentkeys-=0#

" File Matching
setl suffixesadd=.py
setl wildignore+=*.pyc

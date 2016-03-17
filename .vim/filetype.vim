" ~/.vim/filetype.vim: Vim filetype autocommands

if has("autocmd")

" {{{ Text files
au BufNewFile,BufRead           README,TODO,DEVEL           set ft=rst
" }}}

" {{{ Python
" }}}


endif

" vim:set ft=vim fo-=t:

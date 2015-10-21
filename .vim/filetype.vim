" ~/.vim/filetype.vim: Vim filetype autocommands

if has("autocmd")

" {{{ Text files
au BufNewFile,BufRead           *.txt,README,TODO,DEVEL       set ft=rst
" }}}

" {{{ Python
" }}}


endif

" vim:set ft=vim fo-=t:

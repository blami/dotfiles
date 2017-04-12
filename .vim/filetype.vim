" ~/.vim/filetype.vim: Vim filetype autocommands

if has("autocmd")

" {{{ Text files
au BufNewFile,BufRead           README,TODO,DEVEL,*.txt,*.md                    set ft=markdown
" }}}

" {{{ Python
" }}}


endif

" vim:set ft=vim fo-=t:

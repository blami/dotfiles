"File:          c.vim
"Language:      C

"NOTE: Vim treats all .h files as C++. For purely C projects it is recommended
"to have .exrc file in project root with:
"
"  augroup project
"    autocmd!
"    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
"  augroup END
"
"See: https://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"Compiler
compiler clang

"Formatting
setl noexpandtab
setl textwidth=79
setl list

"File Matching
setl suffixesadd=.c,.h

"Keybindings

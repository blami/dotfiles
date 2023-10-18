"File:          qf.vim
"Language:      Vim quickfix and location list

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

setl noexpandtab

"Look and feel
setl nonumber
setl signcolumn=no
setl colorcolumn=
setl nolist

"NOTE: Required to override Vim's statusline
setl statusline=%!statusline#statusline()

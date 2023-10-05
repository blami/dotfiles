"File:          help.vim
"Language:      Vim help file

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl shiftwidth=8 tabstop=8 softtabstop=8
setl noexpandtab

"User Interface
setl nonumber
setl signcolumn=no
setl colorcolumn=
setl nolist

"Keybindings
noremap     <silent><buffer>    <F1>        :q<CR>        

"Autocommands
"Open help window as right split on large terminals
autocmd! BufWinEnter <buffer> if &columns > 120 | wincmd L"{{{"}}} | endif

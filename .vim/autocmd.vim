"Global autocommands

"Highlight annotations and colors
autocmd Syntax * call hl#HighlightAnnotations()
autocmd Syntax * call hl#HighlightColors()

"Restore cursor position
autocmd! BufReadPost * call util#RestoreCursorPosition()
"Restore cursor style after leaving
"autocmd! VimLeave * set guicursor=a:block-blinkoff0

"Refresh help tags
autocmd! VimEnter * :helptags ~/.vim/doc

"Do not use default ftplugins
"autocmd! BufReadPre,BufNewFile * let b:did_ftplugin = 1
"Make backup file name contain full path (because it goes to .local/share/vim)
"autocmd BufWritePre * let &backupext = substitute(expand('%:p:h'), '/', '%', 'g').'~'



"vim:set fo-=t:

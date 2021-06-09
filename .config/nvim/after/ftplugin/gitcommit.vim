"Language: Git commit message
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl expandtab
setl textwidth=72

"Look and feel
setl colorcolumn=73

"Spellchecking
setl spell spelllang=en

"Autocommands
"Reset cursor position to begining of file (autocmd.vim remembers cursor position)
autocmd BufEnter * 
    \ if !exists('b:did_reset') | 
    \   let b:did_reset=1 |
    \   exe 'normal! gg0' |
    \ endif

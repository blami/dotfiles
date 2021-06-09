"Language: C
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
"Do not run further lines for C++
"if (&ft != 'c') | finish | endif

"Formatting
setl noexpandtab
setl textwidth=79

"File Matching
setl suffixesadd=.c,.h

"Keybindings

"Autocommands

"Language server
"TODO

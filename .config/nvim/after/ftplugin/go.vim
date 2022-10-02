"Language: Go
"Maintainer: Ondrej Balaz

"if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1

"TODO: Language Server

"Compiler
compiler go

"Formatting
setl formatoptions-=t
setl noexpandtab
setl textwidth=79

"Comments
setl comments=s1:/*,mb:*,ex:*/,://
setl commentstring=//\ %s

"File Matching
setl suffixesadd=.go

"Keybindings

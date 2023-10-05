"File:          python.vim
"Language:      Python

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl expandtab shiftwidth=4 softtabstop=4 tabstop=8
setl textwidth=119

"Comments
setl comments=b:#,fb:-
setl commentstring=#\ %s
"Don't re-indent # comments
setl cinkeys-=0#
setl indentkeys-=0#

"File Matching
setl suffixesadd=.py
setl wildignore+=*.pyc,*.pyo

"Keybindings

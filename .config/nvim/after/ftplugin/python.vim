"Language: Python
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Language Server
"TODO: Revisit this and make it more 'minimal'
lua blami.lsp.setup(
            \ 'pylsp',
            \ {pylsp={plugins={
            \   ['pylsp_isort']={enabled=true},
            \   ['pylsp_black']={enabled=true},
            \ }}}, 
            \ {}
            \ )

"Formatting
setl expandtab shiftwidth=4 softtabstop=4 tabstop=8
setl textwidth=119
setl list

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
nnoremap    <buffer><silent>        <localleader>t          :call blami#ftplugin#SwitchFile('^\(test_\)\@!\(.*\)\.py$', '\2_test.py', '^test_\(.*\)\.py$', '\1.py')<CR>

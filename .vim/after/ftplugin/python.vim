"Language: Python
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"PEP8 Indentation
setl expandtab shiftwidth=4 softtabstop=4 tabstop=8

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

"Autocommands

"Language Server
if exists('g:lsp_loaded') && executable('pyls')
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ 'workspace_config': {'pyls': {'plugins': {
            \   'black': {'enabled': v:true},
            \   'pycodestyle': {'enabled': v:true},
            \   'pylint': {'enabled': v:true},
            \ }}},
            \ })

    autocmd BufWritePre <buffer> call autofmt#Format()
endif

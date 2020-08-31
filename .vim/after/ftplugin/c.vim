"Language: C
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
"Do not run further lines for C++
"if (&ft != 'c') | finish | endif

"File Matching
setl suffixesadd=.c,.h

"Autocommands

"Language server
if exists('g:lsp_loaded') && executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c'],
            \ })
endif

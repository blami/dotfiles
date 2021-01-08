"Language: C++
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"Formatting
setl textwidth=119
setl colorcolumn=120

"File Matching
setl suffixesadd=.cpp,.cxx,.c++,.h,.hpp,.hxx,.h++

"Autocommands

"Language server
if exists('g:lsp_loaded') && executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['cpp'],
            \ })
    autocmd BufWritePre <buffer> call autofmt#Format()
endif

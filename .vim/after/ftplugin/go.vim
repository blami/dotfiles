"Language: Go
"Maintainer: Ondrej Balaz

"echo b:did_ftplugin
"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"Compiler
compiler go

"Formatting
setl formatoptions-=t
setl noexpandtab

"Comments
setl comments=s1:/*,mb:*,ex:*/,://
setl commentstring=//\ %s

"File Matching
setl suffixesadd=.go

"Keybindings
nnoremap <buffer>   <F5>                    :w<bar>exec '!go run '.shellescape('%')<CR>

"Autocommands

"Language server
if exists('g:lsp_loaded') && executable('gopls')
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls']},
            \ 'whitelist': ['go'],
            \ })
    autocmd BufWritePre <buffer> LspDocumentFormatSync
    autocmd BufWritePre <buffer> call execute('LspCodeActionSync source.organizeImports')
endif

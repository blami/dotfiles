"Language: TypeScript+React
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl expandtab shiftwidth=2 softtabstop=2 tabstop=4
setl tw=119

"File Matching
setl suffixesadd=.ts,.tsx

"Language server
if exists('g:lsp_loaded') && executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
            \ })
    "autocmd BufWritePre <buffer> LspDocumentFormatSync
    "autocmd BufWritePre <buffer> call execute('LspCodeActionSync source.organizeImports')
endif

"Language: TypeScript
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl expandtab shiftwidth=2 softtabstop=2 tabstop=4
setl textwidth=119
let b:autofmt=1                                         "Enable LSP autoformatting

"File Matching
setl suffixesadd=.ts,.tsx

"Autocommands
autocmd BufWritePre <buffer>
            \ lua require'blami.lsp'.autoformat_sync(
            \   1000,
            \   {}
            \ )

"Language server
if !get(s:, 'loaded', v:false)
lua << EOF
require'lspconfig'.tsserver.setup{}
EOF
let s:loaded = v:true
"NOTE This file is shared between typescript and typescriptreact filetypes
exec 'doautocmd FileType '.&ft
endif

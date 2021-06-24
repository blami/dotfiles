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

"Keybindings
"NOTE This is biased towards React development
nnoremap    <buffer><silent>        <localleader>t          :call blami#ftplugin#SwitchFile('^\(.*\)\(\.test\)\@<!\.\(tsx\?\)$', '\1.test.\3', '^\(.*\)\.test\.\(tsx\?\)$', '\1.\2')<CR>

"Autocommands
autocmd BufWritePre <buffer
            \ lua blami.lsp.autoformat_sync(
            \   1000,
            \   {}
            \ )

"Language server
if !get(s:, 'loaded', v:false)
lua << EOF
lspconfig = blami.prequire('lspconfig')
if lspconfig then
    lspconfig.tsserver.setup{}
end
EOF
let s:loaded = v:true
"NOTE This file is shared between typescript and typescriptreact filetypes
exec 'doautocmd FileType '.&ft
endif

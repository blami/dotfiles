"Language: Go
"Maintainer: Ondrej Balaz

"if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1

"Compiler
compiler go

"Formatting
setl formatoptions-=t
setl noexpandtab
setl textwidth=119
let b:autofmt=1                                         "Enable LSP autoformatting

"Comments
setl comments=s1:/*,mb:*,ex:*/,://
setl commentstring=//\ %s

"File Matching
setl suffixesadd=.go

"Keybindings
nnoremap    <buffer>                <localleader>t          :call blami#ftplugin#SwapFile('.go', '_test.go') 

"Autocommands
autocmd BufWritePre <buffer>
            \ lua require'blami.lsp'.autoformat_sync(
            \   1000,
            \   {['textDocument/codeAction'] = {source = {organizeImports = true}}}
            \ )

"Language server
if !get(s:, 'loaded', v:false)
lua << EOF
require'lspconfig'.gopls.setup{}
EOF
let s:loaded = v:true
doautocmd FileType go
endif

"Language: C
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"Compiler
compiler clang

"Formatting
setl noexpandtab
setl textwidth=79
let b:autofmt=1                                         "Enable LSP autoformatting

"File Matching
setl suffixesadd=.c,.h

"Keybindings
"TODO Swap between .c*/.h*

"Autocommands
autocmd BufWritePre <buffer>
            \ lua require'blami.lsp'.autoformat_sync(
            \   1000,
            \   {}
            \ )

"Language server
if !get(s:, 'loaded', v:false)
lua << EOF
require'lspconfig'.clangd.setup{}
EOF
let s:loaded = v:true
doautocmd FileType cpp
endif

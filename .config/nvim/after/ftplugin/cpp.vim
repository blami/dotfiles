"Language: C++
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
"Do not run lines below for C files
if (&ft != 'cpp') | finish | endif

"Compiler
compiler clang

"Formatting
setl noexpandtab
setl textwidth=119
let b:autofmt=1                                         "Enable LSP autoformatting

"File Matching
setl suffixesadd=.cpp,.cxx,.c++,.h,.hpp,.hxx,.h++

"Keybindings
"TODO Swap between .c*/.h*

"Autocommands
autocmd BufWritePre <buffer>
            \ lua blami.lsp.autoformat_sync(
            \   1000,
            \   {}
            \ )

"Language server
if !get(s:, 'loaded', v:false)
lua << EOF
lspconfig = blami.prequire('lspconfig')
if lspconfig then
    lspconfig.clangd.setup{}
end
EOF
let s:loaded = v:true
doautocmd FileType cpp
endif

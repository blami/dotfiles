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
nnoremap    <buffer><silent>        <localleader>t          :call blami#ftplugin#SwitchFile('^\(.*\)\(_test\)\@<!.go$', '\1_test.go', '^\(.*\)_test.go$', '\1.go')<CR>

"Autocommands
autocmd BufWritePre <buffer>
            \ lua blami.lsp.autoformat_sync(
            \   1000,
            \   {['textDocument/codeAction'] = {source = {organizeImports = true}}}
            \ )

"Language server
if !get(s:, 'loaded', v:false)
lua << EOF
lspconfig = blami.prequire('lspconfig')
if lspconfig then
    lspconfig.gopls.setup{}
end
EOF
let s:loaded = v:true
doautocmd FileType go
endif

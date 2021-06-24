"Language: C++
"Maintainer: Ondrej Balaz

"NOTE Depends on compile_commands.json compilation database.
"See: https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

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
"NOTE Following will work only with .cpp-.h pair of extension
nnoremap    <buffer><silent>        <localleader>h          :call blami#ftplugin#SwitchFile('^\(.*\)\.cpp$', '\1.h', '^\(.*\)\.h$', '\1.cpp')<CR>
nnoremap    <buffer><silent>        <localleader>t          :call blami#ftplugin#SwitchFile('^\(.*\)\(_test\)\@<!\.cpp$', '\1_test.cpp', '^\(.*\)_test\.cpp$', '\1.cpp')<CR>

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

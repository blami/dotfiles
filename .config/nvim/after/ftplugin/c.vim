"Language: C
"Maintainer: Ondrej Balaz

"NOTE Nvim (and Vim) treats all .h files as C++. For purely C projects it is
"recommended to have .exrc file in project root with:
"
"  augroup project
"    autocmd!
"    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
"  augroup END
"
"See: https://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/

"NOTE Depends on compile_commands.json compilation database.
"See: https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"Compiler
compiler clang

"Formatting
setl noexpandtab
setl textwidth=79
call blami#autofmt#Enable()                         "Enable LSP autoformatting

"File Matching
setl suffixesadd=.c,.h

"Keybindings
"See NOTE above if this switches c -> h -> cpp
nnoremap    <buffer><silent>        <localleader>h          :call blami#ftplugin#SwitchFile('^\(.*\)\.c$', '\1.h', '^\(.*\)\.h$', '\1.c')<CR>
nnoremap    <buffer><silent>        <localleader>t          :call blami#ftplugin#SwitchFile('^\(.*\)\(_test\)\@<!\.c$', '\1_test.c', '^\(.*\)_test\.c$', '\1.c')<CR>

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
doautocmd FileType c
endif

"Language: TypeScript
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Language Server
lua blami.lsp.setup(
            \ 'tsserver',
            \ {}, 
            \ {}
            \ )

"Formatting
setl expandtab shiftwidth=2 softtabstop=2 tabstop=4
setl textwidth=119
setl list

"File Matching
setl suffixesadd=.ts,.tsx

"Keybindings
"NOTE This is biased towards React development
nnoremap    <buffer><silent>        <localleader>t          :call blami#ftplugin#SwitchFile('^\(.*\)\(\.test\)\@<!\.\(tsx\?\)$', '\1.test.\3', '^\(.*\)\.test\.\(tsx\?\)$', '\1.\2')<CR>

"Language: Go
"Maintainer: Ondrej Balaz

"if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1

"Language Server
lua blami.lsp.setup(
            \ 'gopls',
            \ {}, 
            \ {['textDocument/codeAction']={['source']={['organizeImports']=true}},}
            \ )

"Compiler
compiler go

"Formatting
setl formatoptions-=t
setl noexpandtab
setl textwidth=79
setl list

"Comments
setl comments=s1:/*,mb:*,ex:*/,://
setl commentstring=//\ %s

"File Matching
setl suffixesadd=.go

"Keybindings
nnoremap    <buffer><silent>        <localleader>t          :call blami#ftplugin#SwitchFile('^\(.*\)\(_test\)\@<!\.go$', '\1_test.go', '^\(.*\)_test\.go$', '\1.go')<CR>

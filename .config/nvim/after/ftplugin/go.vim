" Language: Go
" Maintainer: Ondrej Balaz

" Neovim/plugin ftplugins are disabled. See autocmd.vim.
"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

" Compiler
compiler go

" Formatting
setl formatoptions-=t
setl noexpandtab

" Comments
setl comments=s1:/*,mb:*,ex:*/,://
setl commentstring=//\ %s

" File Matching
setl suffixesadd=.go

" Keybindings
nnoremap            <F5>                    :w<bar>exec '!go run '.shellescape('%')<CR>

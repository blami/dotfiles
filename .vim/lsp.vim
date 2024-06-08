"File:          lsp.vim
"Description:   Language server protocol setup

"Environment variable LSP=0 disables LSP everywhere.

"plugins/opt/lsp depends on Vim 9 script
if has("vim9script") && has("packages") && $LSP != "0"
    packadd lsp
endif

"This function should be used from filetype plugins to setup LSP, pre and post
"save actions, etc.

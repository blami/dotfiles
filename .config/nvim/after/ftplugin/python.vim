"Language: Python
"Maintainer: Ondrej Balaz

"if exists("b:did_ftplugin") | finish | endif
"let b:did_ftplugin = 1

"Formatting
setl expandtab shiftwidth=4 softtabstop=4 tabstop=8
setl textwidth=119
let b:autofmt=1                                         "Enable LSP autoformatting

"Comments
setl comments=b:#,fb:-
setl commentstring=#\ %s
"Don't re-indent # comments
setl cinkeys-=0#
setl indentkeys-=0#

"File Matching
setl suffixesadd=.py
setl wildignore+=*.pyc,*.pyo

"Keybindings

"Autocommands
autocmd BufWritePre <buffer>
            \ lua require'blami.lsp'.autoformat_sync(
            \   1000,
            \   {}
            \ )

"Language Server
if !get(s:, 'loaded', v:false)
lua << EOF
require'lspconfig'.pylsp.setup{
    settings = {
        pylsp = { plugins = {
            pylint = {enabled = true},
            pylsp_black = {enabled = true},
            pylsp_isort = {enabled = true},
            ["mypy-ls"] = {enabled = true, strict=true},

            -- disabled standard plugins
            pycodestyle = {enabled = false},
            autopep8 = {enabled = false},
            yapf = {enabled = false},
            pydocstyle = {enabled = false},
        }}
    }
}
EOF
let s:loaded = v:true
doautocmd FileType python
endif

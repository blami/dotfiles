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
            \ lua blami.lsp.autoformat_sync(
            \   1000,
            \   {}
            \ )

"Language Server
if !get(s:, 'loaded', v:false)
lua << EOF
lspconfig = blami.prequire('lspconfig')
if lspconfig then
    lspconfig.pylsp.setup{
        settings = {
            pylsp = { plugins = {
                -- TODO configure these to 119 line length and reasonable defaults
                pylint = {enabled = true},
                pylsp_black = {enabled = true},
                pylsp_isort = {enabled = true},
                ["mypy-ls"] = {enabled = true, strict=false},

                -- disabled standard plugins
                pycodestyle = {enabled = false},    -- covered by pylint
                autopep8 = {enabled = false},       -- covered by black
                yapf = {enabled = false},           -- covered by black
                pydocstyle = {enabled = false},
            }}
        }
    }
end
EOF
let s:loaded = v:true
doautocmd FileType python
endif

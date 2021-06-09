"pack plugins https://github.com/neovim/nvim-lspconfig
"pack plugins https://github.com/hrsh7th/nvim-compe
"Neovim internal LSP related plugins

set completeopt=menuone,noselect

lua << EOF
require'compe'.setup {
    enabled = true;
    source = {
        nvim_lsp = true;
        vsnip = true;
    }
}
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

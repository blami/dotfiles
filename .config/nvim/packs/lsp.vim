"pack plugins https://github.com/neovim/nvim-lspconfig
"pack plugins https://github.com/hrsh7th/nvim-compe
"Neovim internal LSP related plugins

set completeopt=menuone,noselect

lua << EOF
local ok, compe = pcall(require, 'compe')
if ok then
    compe.setup {
        enabled = true;
        source = {
            nvim_lsp = true;
            vsnip = true;
        }
    }
    vim.g.compe_enabled = true
end
EOF

"inoremap <silent><expr> <C-Space> compe#complete()
"inoremap <silent><expr> <CR>      compe#confirm('<CR>')

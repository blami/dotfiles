"pack plugins https://github.com/neovim/nvim-lspconfig
"pack plugins https://github.com/hrsh7th/nvim-compe
"Neovim internal LSP related plugins

set completeopt=menuone,noselect

lua << EOF
compe = blami.prequire("compe")
if compe then
    compe.setup {
        enabled = true;
        source = {
            nvim_lsp = true;
            vsnip = true;
        }
    }

    -- compe doesn't set g:loaded_compe, useful for keymap.vim
    vim.g.loaded_compe = 1
end
EOF

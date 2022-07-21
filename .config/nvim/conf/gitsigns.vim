"Configure gitsigns
"NOTE: This runs after gitsigns.nvim pack is added.

lua << EOF
gitsigns = blami.prequire('gitsigns')
if not gitsigns then return end

-- gitsigns does not set g:loaded_gitsigns
vim.api.nvim_set_var('loaded_gitsigns', 1)

-- Setup gitsigns
gitsigns.setup({
    signs = {
        add         = {hl='GitAdd'        , text='+'},
        delete      = {hl='GitSignsDelete', text='-'},
        topdelete   = {hl='GitSignsDelete', text='-'},
        changeDelete= {hl='GitSignsDelete', text='-'},
        change      = {hl='GitSignsChange', text='~'},
    },
    signcolumn = true,
    on_attach = function(bufnr)
        -- Add statusline page called git with current status
        vim.fn['blami#statusline#PageAdd']('git', function()
            s = vim.api.nvim_buf_get_var(bufnr, 'gitsigns_status_dict')
            -- handle head
            if s['head'] == '' then s['head'] = '-' end

            r = (s['added'] and s['added'] > 0 and '+' .. s['added'] or '')
            r = r .. (s['changed'] and s['changed'] > 0 and '~' .. s['changed'] or '')
            r = r .. (s['removed'] and s['removed'] > 0 and '-' .. s['removed'] or '')
            return '' .. s['head'] .. (r and ' ' .. r or '')
        end)
    end,
    preview_config = {
        border = 'none',
    }
})

-- Remove autoinstalled highlights and keymaps

EOF

local M = {}

-- Format buffer synchronously by running pre-defined code actions first.
--
-- Meant to be installed to BufWritePre. Run any code actions stored in
-- b:blami_lsp_actions synchronously; then run formatting_sync.
function M.formatting_sync()
    -- Run custom code actions saved by blami.lsp.setup()
    for method, context in next, vim.b.blami_lsp_actions, nil do
        local params = vim.lsp.util.make_range_params()
        params.context = context
        local resp = vim.lsp.buf_request_sync(0, method, params, timeout)
        if resp ~= nil then 
            for _, v in next, resp, nil do
                local result = v.result
                if result and result[1] then
                    vim.lsp.util.apply_workspace_edit(result[1].edit)
                end
            end
        end
    end
    -- Format code
    vim.lsp.buf.formatting_sync()
end

-- One-line LSP setup helper.
--
-- This is meant to be loaded from top of ftplugin. It will load given language
-- server (must be known to `lspconfig`) with given options
function M.setup(server, options, actions)
    local lspconfig = blami.prequire('lspconfig')
    if not lspconfig then return end

    -- FIXME: need to pass actions to formatting_sync()
    vim.b.blami_lsp_actions = actions

    -- Setup language server on attach
    orig_on_attach = options.on_attach
    options.on_attach=function(client)
        blami.autofmt.enable()
        -- NOTE: Needs to be blami.* as it is not in scope of this file
        vim.api.nvim_command('autocmd BufWritePre <buffer> lua blami.autofmt.wrap(blami.lsp.formatting_sync)')
        if orig_on_attach then orig_on_attach(client) end
    end

    -- Avoid autostart so that each buffer can control itself
    options.autostart=false

    if not vim.tbl_contains(lspconfig.available_servers(), server) then
        lspconfig[server].setup(options)
    end

    -- Start LSP in this buffer
    lspconfig[server].manager.try_add()
end


return M

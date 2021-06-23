local lsp = {}

-- Autoformat code 
function lsp.autoformat_sync(timeout, actions)
    if vim.b.autofmt ~= 1 then return end

    -- Run all specified code actions first
    for method, context in next, actions, nil do
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


return lsp

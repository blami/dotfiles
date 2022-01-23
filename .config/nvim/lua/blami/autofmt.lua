local M = {}

-- Set buffer autofmt flag
-- 
-- Set b:autofmt to 1 unless either NOAUTOFMT variable is set or current or any
-- of LSP workspace directories contains file '.noautocmd' (with any content).
--
-- NOTE: This is called by blami.lsp.setup() if LSP is enabled; otherwise needs
-- to be called manually from ftplugin.
function M.enable()
    if os.getenv('NOAUTOFMT') then vim.b.autofmt=0 return end

    -- TODO: Perhaps should fallback to '.' only if no LSP workspaces?
    local dirs = {'.'}
    for _, d in ipairs(vim.lsp.buf.list_workspace_folders()) do
        table.insert(dirs, d)
    end
    for _, d in ipairs(dirs) do
        local f = io.open(d .. '/.noautofmt')
        if f then io.close(f) vim.b.autofmt=0 return end
    end
    vim.b.autofmt=1
end

-- Wrap Lua function(s) or Vim command(s) call with b:autofmt check.
--
-- If b:autofmt is 1 run all passed Lua functions or Vim commands; otherwise
-- just do nothing.
function M.wrap(...)
    local args={...}
    if vim.b.autofmt ~= 1 then return end
    for _, a in ipairs(args) do 
        if type(a) == 'function' then a() end
        if type(a) == 'string' then vim.api.nvim_command(a) end 
    end
end


return M
